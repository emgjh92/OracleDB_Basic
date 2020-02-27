--박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구입한 고객의 이름

select distinct customer.name,book.publisher,book.bookname from customer, book, orders 
where book.publisher in 
(select book.publisher from customer,book,orders where customer.name like '박지성'
and book.bookid=orders.bookid and customer.custid=orders.custid) and customer.name not like '박지성' 
and book.bookid=orders.bookid and customer.custid=orders.custid;


--두개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select NAME
from CUSTOMER s1
where (select count(distinct publisher) from customer t1, orders t2, book t3
                                            where t1.custid = t2.custid
                                            and t2.bookid = t3.bookid
                                            and t1.name = s1.name) >= 2;

--OR

select (select name from customer inner_cs where cs.custid=inner_cs.custid) 
from Customer cs, orders od, book bk
where cs.custid=od.custid and od.bookid=bk.bookid
group by cs.custid
having count(distinct bk.publisher)>=2;


--전체 고객의 30%이상이 구매한 도서

select (select bk.bookname from book bk where bk.bookid = od.bookid) from orders od
group by od.bookid having count(distinct od.custid) > (select count(*)*0.3 from customer);

--OR

select bookname
from book s1
where((select count(book.bookid) from book,orders 
        where book.bookid=orders.bookid and book.bookid=s1.bookid) 
        >=0.3*(select count(*) from customer));
