# GPT Context (kjspringweb-legacy)

이 파일은 `kjspringweb-legacy` 프로젝트의 세션 맥락 기준 파일이다.
새 세션에서 이 프로젝트를 작업할 때 먼저 읽고, 설계/운영 전제가 바뀌면 이 파일에 인계 메모를 남긴다.

## 1) 왜 만들었나
- 기존 `D:\workspace\kjspringweb`는 Spring Boot 4 기반 대상 서버다.
- TurtlePick agent는 Boot 전용이 아니라 레거시 Spring/WAR/외장 Tomcat 환경까지 붙어야 한다.
- 그래서 Boot 대상 서버와 별도로, 하한 호환성 검증용 레거시 Spring 대상 서버가 필요하다.
- 이 프로젝트는 그 목적의 최소 골격이다.

## 2) 무엇에 쓰는 프로젝트인가
- TurtlePick javaagent의 비-Boot 대상 서버 호환성 검증용 표본이다.
- 검증 초점은 기능 완성도가 아니라 아래 환경에서 agent가 정상 동작하는지 확인하는 것이다.
  - Spring Boot 없음
  - `web.xml` 기반 부트스트랩
  - XML bean 설정
  - `javax.servlet` 기반 WAR
  - 외장 Tomcat 배포 전제
  - Spring MVC 4.x
  - Spring Security 4.x filter chain
  - MyBatis XML DAO 호출
  - SQLite 파일 DB
  - 서버 세션 기반 form-login 인증

## 3) 현재 기술 기준
- Java: Java 8 bytecode
- 빌드 JDK: 현재 PC 기본 JDK 17 사용, Gradle `options.release = 8`로 Java 8 호환 컴파일
- 런타임 하한 검증: 설치된 Java 8 JRE(`C:\Program Files\Java\jre1.8.0_461`) 사용 가능
- Spring Framework / MVC: `4.3.30.RELEASE`
- Spring Security: `4.2.20.RELEASE`
- MyBatis: `3.5.16`
- MyBatis-Spring: `1.3.3`
- SQLite JDBC: `3.36.0.3`
- Servlet API: `javax.servlet-api 3.1.0` provided
- Packaging: WAR

## 4) 현재 생성 상태
- 루트: `D:\workspace\kjspringweb-legacy`
- 핵심 파일:
  - `build.gradle`
  - `settings.gradle`
  - `src/main/webapp/WEB-INF/web.xml`
  - `src/main/webapp/WEB-INF/application-context.xml`
  - `src/main/webapp/WEB-INF/dispatcher-servlet.xml`
  - `src/main/webapp/WEB-INF/security-context.xml`
  - `src/main/resources/mybatis/mapper/BoardLegacyMapper.xml`
  - `src/main/resources/schema.sql`
  - `src/main/resources/data.sql`
- 기본 기능:
  - `/login`
  - `/`
  - `/legacy/boards`
  - `/legacy/boards/{id}`

## 5) 검증 완료
- 아래 명령으로 WAR 빌드 성공 확인.

```powershell
D:\workspace\kjspringweb\gradlew.bat -p D:\workspace\kjspringweb-legacy clean war
```

- 산출물:
  - `D:\workspace\kjspringweb-legacy\build\libs\kjspringweb-legacy-0.0.1-SNAPSHOT.war`

## 6) 다음 작업
1. 외장 Tomcat 실행 방식을 정한다.
2. WAR를 배포해 `/login` 및 `/legacy/boards` 접근을 확인한다.
3. TurtlePick agent를 `-javaagent`로 붙여 Spring MVC 4.x + `javax.servlet` 환경에서 HTTP hook이 동작하는지 확인한다.
4. MyBatis XML mapper 호출이 후속 SQL/DAO 계측 검증 대상이 되도록 시나리오를 보강한다.

## 7) 작업 규칙
- 이 프로젝트는 레거시 호환성 검증 표본이므로 Boot 의존성을 추가하지 않는다.
- 편의를 위해 Spring Boot starter, 내장 Tomcat, auto-configuration을 도입하지 않는다.
- 기능은 작게 유지하되, 레거시 환경 특성(`web.xml`, XML bean, WAR, MyBatis XML)은 보존한다.
- 테스트/실행 산출물은 루트에 직접 만들지 않고 `logs/`, `build/`, 별도 검증 디렉터리에 둔다.
## 8) 2026-05-09 SQLite + 세션 인증 전환
- 사용자 지시에 따라 DB를 H2에서 SQLite로 변경했다.
- `build.gradle`에서 H2 의존성을 제거하고 `org.xerial:sqlite-jdbc:3.36.0.3`을 추가했다.
- `application-context.xml`의 datasource는 `org.sqlite.JDBC`, `jdbc:sqlite:${legacy.sqlite.path:kjspringweb-legacy.db}`를 사용한다.
- `schema.sql`은 SQLite 문법으로 변경했다.
  - `create table if not exists`
  - `id integer primary key autoincrement`
  - `content text`
- `data.sql`은 재기동 시 중복 삽입되지 않도록 `where not exists` 기반 insert로 변경했다.
- 인증은 Spring Security 4.x의 서버 세션 기반 form-login으로 유지/명시했다.
  - `create-session="ifRequired"`
  - `<session-management invalid-session-url="/login"/>`
- 검증: 기존 Gradle wrapper로 `clean war` 성공.
## 9) 2026-05-09 Maven 전환
- 사용자 방향에 따라 레거시 프로젝트답게 Gradle 대신 Maven 기반 WAR 프로젝트로 전환했다.
- `pom.xml`을 생성했고, 빌드 기준은 Maven `war` packaging이다.
- `build.gradle`, `settings.gradle`은 삭제하지 않고 `build.gradle.bak`, `settings.gradle.bak`로 이동했다.
- Maven 기준 산출물은 `target/kjspringweb-legacy.war`다.
- 이후 `D:\workspace\tools\apache-maven-3.9.9` 포터블 Maven을 설치했고 `mvn clean package` 검증까지 완료했다.
- Maven Wrapper는 추가하지 않았다. 현재 기준은 포터블 Maven 경로를 직접 호출하는 방식이다.
## 10) 2026-05-09 Maven/Tomcat 포터블 설치 및 Maven 빌드 검증
- 사용자 지시 `설치해. 확정 반영`에 따라 전역 설치가 아니라 `D:\workspace\tools` 하위 포터블 설치로 진행했다.
- 설치 경로:
  - Maven: `D:\workspace\tools\apache-maven-3.9.9`
  - Tomcat: `D:\workspace\tools\apache-tomcat-8.5.100`
  - 다운로드 zip 보관: `D:\workspace\tools\downloads`
- Maven 확인:
  - `D:\workspace\tools\apache-maven-3.9.9\bin\mvn.cmd -version`
  - Apache Maven 3.9.9 확인 완료.
- Tomcat 확인:
  - `CATALINA_HOME`/`CATALINA_BASE`를 `D:\workspace\tools\apache-tomcat-8.5.100`으로 지정 후 `catalina.bat version` 실행.
  - Apache Tomcat/8.5.100 확인 완료.
- Maven 빌드 검증:
  - `D:\workspace\tools\apache-maven-3.9.9\bin\mvn.cmd -f D:\workspace\kjspringweb-legacy\pom.xml clean package`
  - BUILD SUCCESS.
  - 산출물: `D:\workspace\kjspringweb-legacy\target\kjspringweb-legacy.war`
- 아직 미수행:
  - Tomcat에 WAR 배포 후 `/login` 접속 검증.
  - Tomcat JVM에 TurtlePick `-javaagent` 부착 검증.
## 11) 2026-05-09 레거시 검증 기능 구현 및 smoke 완료
- 사용자 지시에 따라 `kjspringweb`에 없는 기능 위주, 에러 유도 쉬운 구조, 화면 validation 없음 원칙으로 기능을 구현했다.
- 추가 기능:
  - `/ops`: 벤더/재고/DB 큐 운영 실험실.
  - `/settlements`: 서버 세션 기반 정산 작업함.
  - `/file-import`: 파일 dropbox 등록/처리.
- 에러 유도 포인트:
  - `Long.valueOf(...)`, `Integer.valueOf(...)` 직접 파싱으로 숫자 입력 오류 유도.
  - SQLite `UNIQUE`, `NOT NULL`, `CHECK` 제약 위반 유도.
  - MyBatis XML에서 `order by ${sortColumn}` raw SQL 조각을 사용해 잘못된 컬럼/SQL 오류 유도.
  - DB queue `forceErrorCode=NPE|SQL|NEGATIVE_STOCK`로 NPE, CHECK 제약, 상태값 CHECK 오류 유도.
  - 파일 import는 `D:/workspace/kjspringweb-legacy/dropbox` 기준 파일 없음 및 row count mismatch 유도.
- 추가 파일군:
  - `LegacyOpsMapper`, `LegacyOpsMapper.xml`
  - `VendorLegacy`, `InventoryLegacy`, `JobQueueLegacy`, `SettlementLegacy`, `FileManifestLegacy`, `WorkItem`
  - `LegacyOpsService`, `SettlementService`, `FileImportService`
  - `LegacyOpsController`, `SettlementController`, `FileImportController`, `LegacyErrorController`
  - JSP: `ops/dashboard.jsp`, `settlement/index.jsp`, `fileimport/index.jsp`, `error/legacy-error.jsp`
- 검증:
  - Maven `clean package` 성공.
  - Tomcat 8.5.100 별도 base(`runtime/tomcat-base`) + 18080 포트로 WAR 배포 성공.
  - `/kjspringweb-legacy/login` HTTP 200 및 form 확인.
  - 세션 로그인(`user/password`) 후 `/kjspringweb-legacy/ops` HTTP 200 확인.
  - `creditLimit=abc` POST로 `NumberFormatException` 에러 화면(`Legacy Error Observed`) 노출 확인.
- 검증용 Tomcat은 종료했다. 18080 리슨 없음.
- 다음 작업: TurtlePick agent `-javaagent`를 Tomcat JVM에 붙여 legacy Spring MVC 4 + javax.servlet 환경에서 HTTP hook/trace/log-ready가 동작하는지 확인한다.
## 12) 2026-05-09 운영형 날짜별 서버 로그 반영
- 사용자 지시에 따라 레거시 프로젝트 서버 로그를 콘솔 전용에서 운영형 날짜별 파일 로그로 변경했다.
- 변경 파일: `src/main/resources/logback.xml`
- 로그 정책:
  - `legacy-app.log`: INFO 이상 현재 로그.
  - `legacy-app.%d{yyyy-MM-dd}.log`: 일자별 일반 로그, `maxHistory=14`.
  - `legacy-error.log`: ERROR 이상 현재 로그.
  - `legacy-error.%d{yyyy-MM-dd}.log`: 일자별 에러 로그, `maxHistory=30`.
  - 기본 경로: `D:/workspace/kjspringweb-legacy/logs/app`
  - JVM 옵션 `-Dlegacy.log.path=...`로 변경 가능.
- 운영 확인을 위해 `HomeController`에 login/home 접근 INFO 로그를 추가했다.
- `LegacyErrorController`는 exception을 ERROR 로그로 남긴다.
- 검증:
  - Maven `clean package` 성공.
  - Tomcat smoke에서 `/kjspringweb-legacy/login` HTTP 200.
  - `legacy-app.log`에 `legacy login page requested` INFO 로그 기록 확인.
  - 검증용 Tomcat 종료 완료.
## 13) 2026-05-09 매일 에러 패턴 배치 추가
- 사용자 질문에 따라 매일 패턴별로 에러를 터뜨리는 레거시 배치를 추가했다.
- Spring Boot Batch가 아니라 레거시 Spring `task:scheduled` 기반이다.
- 추가 파일:
  - `src/main/java/com/kjweb/legacy/batch/LegacyErrorPatternBatch.java`
  - `src/main/java/com/kjweb/legacy/web/controller/BatchLabController.java`
- 설정:
  - `application-context.xml`에 `task` namespace, `legacyTaskScheduler`, `<task:scheduled-tasks>` 추가.
  - cron: `0 35 3 * * *` (매일 03:35)
- 패턴:
  - `dayOfMonth % 5 == 0`: vendor duplicate UNIQUE 실패.
  - `== 1`: inventory negative CHECK 실패.
  - `== 2`: job status `BROKEN_STATUS` CHECK 실패.
  - `== 3`: `NumberFormatException`.
  - `== 4`: `NullPointerException`.
- `/ops` 화면에 수동 실행 form을 추가했다.
  - `daily`, `duplicate`, `inventory`, `status`, `number`, `npe`
- 검증:
  - Maven `clean package` 성공.
  - Tomcat smoke에서 context 초기화 성공.
  - 로그인 후 `/ops` HTTP 200.
  - `/ops` 화면에 `Daily Error Batch Manual Trigger` 노출 확인.
  - 검증용 Tomcat 종료 완료.

## 14) 2026-05-09 Java 8 release / SQLite WAL / Async Lab 반영
- Gemini 분석에 대한 사용자 지시 `확정 반영`으로 다음 개선안을 반영했다.
- Java 8 호환:
  - `pom.xml`의 `maven-compiler-plugin`을 `source/target 1.8`에서 `<release>8</release>`로 변경했다.
  - JDK 17 컴파일 환경에서 Java 9+ 표준 API가 섞이는 것을 컴파일 단계에서 차단하기 위한 조치다.
- SQLite 동시성 노이즈 완화:
  - `application-context.xml`의 JDBC URL에 `journal_mode=WAL`, `busy_timeout=5000`을 추가했다.
  - 의도한 UNIQUE/CHECK/파싱 오류 대신 짧은 파일 락으로 `SQLITE_BUSY`가 먼저 터지는 경우를 줄이기 위한 조치다.
- Servlet 3.1 async 검증:
  - `web.xml`의 `springSecurityFilterChain`, `DispatcherServlet`에 `<async-supported>true</async-supported>`를 추가했다.
  - `AsyncLabController`를 추가했다.
  - 경로:
    - `/async-lab/callable`
    - `/async-lab/callable-error`
    - `/async-lab/deferred`
    - `/async-lab/deferred-error`
  - 목적은 TurtlePick agent의 ThreadLocal trace context가 Spring MVC 4.x 비동기 경계에서 어떻게 동작하는지 검증하는 것이다.
- 검증:
  - Maven `clean package` 성공.
  - 컴파일 로그에서 `javac [debug release 8]` 확인.
  - Tomcat 8.5.100 `runtime/tomcat-base`를 새 WAR로 재배포했다.
  - 로그인 후 `/async-lab/callable` HTTP 200, `legacy callable async ok` 확인.
  - 로그인 후 `/async-lab/deferred` HTTP 200, `legacy deferred async ok` 확인.
  - `/async-lab/callable-error`, `/async-lab/deferred-error`는 `Legacy Error Observed` 화면과 의도한 에러 메시지 노출 확인.
