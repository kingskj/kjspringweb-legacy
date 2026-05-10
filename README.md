# kjspringweb-legacy

TurtlePick agent의 레거시 Spring 호환성을 검증하기 위한 대상 서버입니다.

기존 `kjspringweb`가 Spring Boot 기반 검증 대상이라면, 이 프로젝트는 Boot가 없는 전통적인 Spring MVC WAR 애플리케이션을 기준으로 합니다. 목적은 기능 많은 업무 시스템을 만드는 것이 아니라, TurtlePick javaagent가 레거시 Spring 실행 환경에서도 요청 흐름과 실패 지점을 관측할 수 있는지 확인하는 것입니다.

## 설계 원칙

- Spring Boot를 사용하지 않습니다.
- 내장 Tomcat이나 auto-configuration에 기대지 않습니다.
- 외장 Servlet 컨테이너에 WAR로 배포되는 구조를 유지합니다.
- `web.xml`, XML Spring bean 설정, `javax.servlet` 기반 흐름을 보존합니다.
- 화면단 입력 검증은 의도적으로 최소화합니다.
- 잘못된 입력은 서비스, MyBatis, DB 제약, 서버 예외 단계에서 드러나게 둡니다.
- 무거운 외부 인프라 대신 SQLite, DB queue, 파일 dropbox 같은 가벼운 검증 흐름을 사용합니다.

## 기술 스펙

| 영역 | 선택 |
|---|---|
| Java 바이트코드 | 8 |
| Spring Framework / MVC | 4.3.30.RELEASE |
| Spring Security | 4.2.20.RELEASE |
| MyBatis | 3.5.16 |
| MyBatis-Spring | 1.3.3 |
| SQLite JDBC | 3.36.0.3 |
| Servlet API | javax.servlet 3.1.0 provided |
| View | JSP |
| Packaging | WAR |
| 인증 | Spring Security form-login / 서버 세션 |

## 검증 대상 흐름

| 영역 | 경로 | 검증 포인트 |
|---|---|---|
| 로그인/세션 | `/login` | Spring Security 4.x form-login, 서버 세션 인증 |
| 게시글 | `/`, `/legacy/boards/{id}` | Spring MVC Controller, JSP, MyBatis XML 단건/목록 조회 |
| 운영 실험실 | `/ops` | 벤더/재고 등록, raw `order by ${sortColumn}`, DB queue 처리 |
| 정산 작업함 | `/settlements` | 서버 세션 임시 작업함, 직접 DB insert, 일괄 commit |
| 파일 처리 | `/file-import` | 파일 manifest 등록, dropbox 파일 존재/행 수 검증 |
| 비동기 MVC | `/async-lab/*` | Servlet 3.1 async, `Callable`, `DeferredResult`, 비동기 예외 |
| 스케줄 배치 | Spring `task:scheduled` | 날짜별 장애 패턴 수동/자동 실행 |

## 의도적 실패 지점

- 숫자 파싱 실패: 문자 입력을 `Long.valueOf`, `Integer.valueOf`에서 그대로 처리
- DB 제약 실패: SQLite `UNIQUE`, `NOT NULL`, `CHECK`
- SQL 오류: MyBatis XML의 raw 정렬 SQL 조각
- 큐 처리 실패: `NPE`, `SQL`, `NEGATIVE_STOCK` 강제 오류 코드
- 파일 처리 실패: 파일 없음, 예상 행 수 불일치
- 비동기 예외: `Callable`, `DeferredResult` 내부 예외

## DB와 로그

DB는 SQLite 파일 DB를 사용합니다.

```text
jdbc:sqlite:${legacy.sqlite.path:kjspringweb-legacy.db}?journal_mode=WAL&busy_timeout=5000
```

운영형 로그 파일도 남깁니다. 기본 경로는 JVM 옵션으로 바꿀 수 있습니다.

```text
-Dlegacy.sqlite.path=...
-Dlegacy.log.path=...
```

로그 파일은 일반 로그와 에러 로그를 분리합니다.

| 파일 | 내용 |
|---|---|
| `legacy-app.log` | INFO 이상 일반 로그 |
| `legacy-app.yyyy-MM-dd.log` | 날짜별 일반 로그 |
| `legacy-error.log` | ERROR 이상 에러 로그 |
| `legacy-error.yyyy-MM-dd.log` | 날짜별 에러 로그 |

## 주요 계정

테스트용 계정은 `src/main/webapp/WEB-INF/security-context.xml`에 정의되어 있습니다.

| 계정 | 비밀번호 | 권한 |
|---|---|---|
| `user` | `password` | `ROLE_USER` |
| `admin` | `admin` | `ROLE_ADMIN`, `ROLE_USER` |

## 빌드

Maven 기반 WAR 프로젝트입니다.

```powershell
D:/workspace/tools/apache-maven-3.9.9/bin/mvn.cmd clean package
```

산출물:

```text
target/kjspringweb-legacy.war
```

## 관련 프로젝트

| 프로젝트 | 역할 |
|---|---|
| `turtlepick` | 비즉시성 모니터링 엔진 |
| `kjspringweb` | Spring Boot 기반 TurtlePick 대상 서버 |
| `kjspringweb-legacy` | 레거시 Spring MVC/WAR 기반 TurtlePick 대상 서버 |
