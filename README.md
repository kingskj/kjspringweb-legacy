# kjspringweb-legacy

TurtlePick agent의 레거시 Spring 호환성 검증용 대상 서버입니다.

## 왜 만들었나

기존 `kjspringweb`는 Spring Boot 기반 대상 서버입니다. 하지만 TurtlePick agent는 Boot 전용이 아니라 레거시 Spring 애플리케이션에도 붙어야 합니다.

이 프로젝트는 아래 같은 비-Boot 환경에서 agent가 정상적으로 부착되고 요청 흐름을 관측할 수 있는지 확인하기 위해 만든 최소 골격입니다.

- Spring Boot 없음
- WAR 패키징
- `web.xml` 기반 부트스트랩
- XML Spring bean 설정
- `javax.servlet` 기반
- 외장 Tomcat 배포 전제
- Spring MVC 4.x
- Spring Security 4.x
- MyBatis XML mapper
- SQLite 파일 DB
- 서버 세션 기반 form-login 인증

## 기술 기준

| 영역 | 버전 / 선택 |
|---|---|
| Java 바이트코드 | 8 |
| Spring Framework / MVC | 4.3.30.RELEASE |
| Spring Security | 4.2.20.RELEASE |
| MyBatis | 3.5.16 |
| MyBatis-Spring | 1.3.3 |
| SQLite JDBC | 3.36.0.3 |
| Servlet API | javax.servlet 3.1.0 provided |
| 패키징 | WAR |

## DB와 인증

DB는 SQLite를 사용합니다.

기본 JDBC URL은 아래와 같습니다.

```text
jdbc:sqlite:${legacy.sqlite.path:kjspringweb-legacy.db}
```

외장 Tomcat 실행 시 JVM 옵션으로 DB 파일 위치를 바꿀 수 있습니다.

```text
-Dlegacy.sqlite.path=D:/workspace/kjspringweb-legacy/runtime/kjspringweb-legacy.db
```

인증은 Spring Security 4.x의 서버 세션 기반 form-login 방식입니다. JWT나 토큰 인증은 사용하지 않습니다.


## 현재 구현된 검증 기능

기존 Boot 프로젝트에 없는 흐름 위주로 구성했습니다. 화면단 validation은 없습니다.

| 기능 | 경로 | 에러 유도 포인트 |
|---|---|---|
| Legacy Ops Lab | `/ops` | 숫자 파싱 실패, UNIQUE/CHECK 제약 위반, raw `order by ${sortColumn}` SQL 오류 |
| DB Queue | `/ops` | `NPE`, `SQL`, `NEGATIVE_STOCK` 강제 처리 실패 |
| Session Settlement | `/settlements` | 세션 작업함 누락, 중복 정산, 음수/문자 금액 |
| File Dropbox Import | `/file-import` | 파일 없음, row count mismatch, 중복 파일명, 숫자 파싱 실패 |

의도적으로 막지 않는 것:

- HTML required/min/max/pattern 없음
- JavaScript validation 없음
- Controller validation 없음
- DTO validation 없음
- 잘못된 값은 Service/Mapper/DB 제약에서 터지게 둠
## 주요 경로

| 경로 | 설명 |
|---|---|
| `/login` | Spring Security 로그인 화면 |
| `/` | 게시글 목록 홈 화면 |
| `/legacy/boards` | 레거시 게시글 목록 |
| `/legacy/boards/{id}` | 레거시 게시글 상세 |
| /ops | 운영 실험실: 벤더/재고/DB 큐 |
| /settlements | 세션 기반 정산 작업함 |
| /file-import | 파일 dropbox 처리 |

기본 계정은 `src/main/webapp/WEB-INF/security-context.xml`에 정의되어 있습니다.

| 계정 | 비밀번호 | 권한 |
|---|---|---|
| `user` | `password` | `ROLE_USER` |
| `admin` | `admin` | `ROLE_ADMIN`, `ROLE_USER` |

## 빌드

이 프로젝트는 Maven 기반 WAR 프로젝트입니다.

```powershell
D:/workspace/tools/apache-maven-3.9.9/bin/mvn.cmd clean package
```

산출물 위치:

```text
D:/workspace/kjspringweb-legacy/target/kjspringweb-legacy.war
```

Maven은 전역 설치가 아니라 `D:/workspace/tools/apache-maven-3.9.9`에 포터블 설치되어 있습니다. `mvn clean package` 빌드 검증은 완료했습니다.

## 현재 PC 기준

현재 PC의 기본 컴파일러는 JDK 17입니다. Java 8은 JRE만 설치되어 있습니다. Maven과 Tomcat은 전역 설치가 아니라 `D:/workspace/tools` 하위에 포터블로 설치했습니다.

이 프로젝트는 Maven `maven-compiler-plugin`의 `source/target 1.8` 설정으로 Java 8 호환 바이트코드를 생성합니다. 현재 PC에는 Maven CLI가 없으므로 Maven 설치 후 빌드 검증이 필요합니다.

## 작업 원칙

이 프로젝트에는 Spring Boot를 추가하지 않습니다.

목적은 레거시 Spring 대상 서버를 보존하는 것입니다. 편의를 위해 Boot starter, 내장 Tomcat, auto-configuration을 넣으면 이 프로젝트의 검증 가치가 떨어집니다.

기능은 작게 유지하되 아래 특성은 유지합니다.

- `web.xml`
- XML bean 설정
- WAR
- 외장 Tomcat 전제
- `javax.servlet`
- MyBatis XML mapper
- SQLite 파일 DB
- 서버 세션 기반 form-login 인증




## 매일 에러 패턴 배치

Spring Boot Batch가 아니라 레거시 Spring `task:scheduled` 기반입니다.

- 설정 위치: `src/main/webapp/WEB-INF/application-context.xml`
- 실행 Bean: `LegacyErrorPatternBatch`
- 스케줄: 매일 `03:35:00`
- 목적: 날짜별로 다른 종류의 장애를 일부러 발생시켜 TurtlePick 계측/로그 관측을 검증

패턴은 `dayOfMonth % 5` 기준입니다.

| 패턴 | 장애 |
|---|---|
| 0 | 벤더 코드 중복 INSERT로 UNIQUE 제약 실패 |
| 1 | 재고 음수 조정으로 CHECK 제약 실패 |
| 2 | 큐 상태값 `BROKEN_STATUS`로 CHECK 제약 실패 |
| 3 | 숫자 파싱 실패 |
| 4 | NullPointerException |

수동 실행은 `/ops` 화면의 `Daily Error Batch Manual Trigger`에서 할 수 있습니다.
## 서버 로그

운영 서버처럼 날짜별 파일 로그를 남깁니다.

기본 로그 경로:

```text
D:/workspace/kjspringweb-legacy/logs/app
```

외장 Tomcat 실행 시 JVM 옵션으로 변경할 수 있습니다.

```text
-Dlegacy.log.path=D:/workspace/kjspringweb-legacy/logs/app
```

로그 파일:

| 파일 | 내용 | 보관 |
|---|---|---|
| `legacy-app.log` | INFO 이상 현재 로그 | 날짜별 롤링, 14일 |
| `legacy-app.yyyy-MM-dd.log` | 지난 일자 일반 로그 | 14일 |
| `legacy-error.log` | ERROR 이상 현재 로그 | 날짜별 롤링, 30일 |
| `legacy-error.yyyy-MM-dd.log` | 지난 일자 에러 로그 | 30일 |

로그 패턴은 운영 확인용으로 짧게 유지합니다.
## 로컬 도구

| 도구 | 위치 | 확인 |
|---|---|---|
| Maven 3.9.9 | `D:/workspace/tools/apache-maven-3.9.9` | `mvn -version` 확인 완료 |
| Tomcat 8.5.100 | `D:/workspace/tools/apache-tomcat-8.5.100` | `catalina version` 확인 완료 |

Tomcat은 실행 시 `CATALINA_HOME`, `CATALINA_BASE`를 해당 경로로 지정해서 사용합니다.
## 다음 작업

1. Tomcat smoke는 `runtime/tomcat-base`와 18080 포트로 검증 완료했습니다.
2. `/login` 200, 로그인 후 `/ops` 200, `creditLimit=abc` 에러 화면 노출을 확인했습니다.
3. 다음 작업은 TurtlePick agent를 `-javaagent`로 붙여 Spring MVC 4.x + `javax.servlet` 환경에서 HTTP hook이 동작하는지 확인하는 것입니다.
4. MyBatis XML mapper 호출을 SQL/DAO 계측 검증 시나리오로 확장합니다.