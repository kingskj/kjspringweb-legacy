insert into legacy_board(title,content,created_at) select '레거시 Spring MVC','Spring MVC 4.x 컨트롤러, JSP 뷰, XML 설정 기반 요청 흐름을 확인하는 기본 게시글입니다.',current_timestamp where not exists (select 1 from legacy_board where title='레거시 Spring MVC');
insert into legacy_board(title,content,created_at) select 'TurtlePick 계측 확인','WAR 패키징, javax.servlet, MyBatis XML 매퍼 호출을 TurtlePick 에이전트가 추적하는지 확인하는 기준 데이터입니다.',current_timestamp where not exists (select 1 from legacy_board where title='TurtlePick 계측 확인');
insert into legacy_vendor(code,name,credit_limit) select 'V-DEFAULT','기본 벤더',100000 where not exists (select 1 from legacy_vendor where code='V-DEFAULT');
insert into legacy_inventory(sku,name,quantity) select 'SKU-BASE','기본 재고',10 where not exists (select 1 from legacy_inventory where sku='SKU-BASE');
