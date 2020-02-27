# OracleDB_Basic

select * from customer cs
where exists(select * from orders od where od.custid=cs.custid);

--> 상관 부속질의 예시
