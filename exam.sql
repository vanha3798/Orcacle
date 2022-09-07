----- faculty (Khoa trong tr??ng)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-------- subject (M�n h?c)--------------
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);

-------------- student (Sinh vi�n)------
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- gi?i t�nh
	birthday date not null,
	hometown nvarchar2(100) not null, -- qu� qu�n
	schoolarship number, -- h?c b?ng
	faculty_id number not null constraint faculty_id references faculty(id) -- m� khoa
);

--------------- exam management (B?ng ?i?m)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- s? l?n thi (thi tr�n 1 l?n ???c g?i l� thi l?i) 
	mark number(4,2) not null -- ?i?m
);

----+++++++++INSERT DATA++++++++++++++++-----------
--------- faculty
insert into faculty values (1, n'Anh - V?n');
insert into faculty values (2, n'Tin h?c');
insert into faculty values (3, n'Tri?t h?c');
insert into faculty values (4, n'V?t l�');

----- subject
insert into subject (id, name, lesson_quantity) values (1, n'C? s? d? li?u', 45);
insert into subject values (2, n'Tr� tu? nh�n t?o', 45);
insert into subject values (3, n'Truy?n tin', 45);
insert into subject values (4, n'?? h?a', 60);
insert into subject values (5, n'V?n ph?m', 45);

-------- student
insert into student values (1, n'Nguy?n Th? H?i', n'N?', to_date('19900223', 'YYYYMMDD'), 'H� N?i', 130000, 2);
insert into student values (2, n'Tr?n V?n Ch�nh', n'Nam', to_date('19921224', 'YYYYMMDD'), 'B�nh ??nh', 150000, 4);
insert into student values (3, n'L� Thu Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'L� H?i Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Tr?n Anh Tu?n', n'Nam', to_date('19901220', 'YYYYMMDD'), 'H� N?i', 180000, 1);
insert into student values (6, n'Tr?n Thanh Mai', n'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Ph�ng', null, 3);
insert into student values (7, n'Tr?n Th? Thu Th?y', n'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Ph�ng', 10000, 1);

---------- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);

select * from faculty;
select * from subject;
select * from student;
select * from exam_management;


 /********* A. BASIC QUERY *********/
-- 1. Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t?:
--      a. id t?ng d?n
select * from student
  order by id asc;
--      b. gi?i t�nh
select * from student
  order by gender;
--      c. ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N
select * from student
  order by birthday asc; 
select * from student
  order by schoolarship desc;

-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'
select * from subject
  where name like 'T%';
  
-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
select * from student
  where name like '%i';
  
-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
select * from faculty
  where substr(name, 2, 1)='n';

-- 5. Sinh vi�n trong t�n c� t? 'Th?'
select * from student
  where name like '%Th?%';
  
-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
select * from student
  where substr(name, 1, 1)>='A' and substr(name, 1, 1)<='M'
  order by name;
  
-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
select * from student
  where schoolarship >100000
  order by faculty_id desc;

-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
select * from student
  where schoolarship >150000 and hometown in ('H� N?i');

-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
select * from student
  where birthday >='01-JAN-1991' and birthday<= '05-JUN-1992';
  
-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
select * from student
  where schoolarship >=80000 and schoolarship <=150000;
  
-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
select * from subject
  where lesson_quantity >30 and lesson_quantity <45;


/********* B. CALCULATION QUERY *********/
-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
		-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.
select id "M� sinh vi�n", gender "Gi?i t�nh", faculty_id "m� khoa", schoolarship "H?c b?ng", 
(case
 when  schoolarship > 500000 then 'H?c b?ng cao'
 else 'M?c trung b�nh'
end) as "M?c h?c b?ng"
from student;

-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
select count(id) "T?ng sinh vi�n"
from student;

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
select gender "Gi?i t�nh", count(id) "T?ng sinh vi�n"
from student
group by gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa
select faculty_id "m� khoa", count(id) "T?ng sinh vi�n"
from student
group by faculty_id;

-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
select subject_id "m� m�n h?c", count(student_id) "T?ng sinh vi�n"
from exam_management
group by subject_id;

-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
select student_id "m� sinh vi�n",count(*) "s? l??ng m�n h?c"
from exam_management
group by student_id;

-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select faculty_id  "m� khoa", count(*) "T?ng s? h?c b?ng"
from student
group by faculty_id;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty_id  "m� khoa", max(schoolarship) "H?c b?ng cao nh?t"
from student
group by faculty_id;

-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
select faculty_id  "M� khoa",gender "Gi?i t�nh", count(id) "S? sinh vi�n"
from student
group by faculty_id,gender;

-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) "?? tu?i",count(id) "m� sinh vi�n"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)

-- 11. Cho bi?t nh?ng n?i n�o c� �t nh?t 2 sinh vi�n ?ang theo h?c t?i tr??ng
select hometown, count(id) "S? l??ng sv"
from student
group by hometown
having count(id) >=2;

-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n
select student_id "M� sinh vi�n",subject_id "M� m�n h?c",count(number_of_exam_taking) "S? l?n thi l?i"
from student s JOIN exam_management ex ON s.id = ex.student_id
group by student_id,subject_id
having count(number_of_exam_taking)>=2;

-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0 
select name "H? t�n",gender "Gi?i t�nh",number_of_exam_taking,avg(mark) "?i?m trung b�nh"
from student s JOIN exam_management ex ON s.id = ex.student_id
where number_of_exam_taking=1 and gender='Nam'
group by number_of_exam_taking,gender, name
having avg(mark)>7.0;

-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t �t nh?t 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)
select student_id "M� sinh vi�n",count(subject_id) "S? m�n thi tr??t l?n 1"
from exam_management
where number_of_exam_taking = 1 and mark < 4
group by student_id
having count(subject_id)>=2;

-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam
select f.id "M� khoa",f.name "T�n khoa",count(s.id) "S? sinh vi�n nam"
from student s join faculty f on s.faculty_id = f.id
where gender= 'Nam'
group by f.id,f.name
having count(s.id)>=2;

-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000
select s.faculty_id "M� khoa",f.name "T�n khoa",count(s.id) "S? sinh vi�n "
from student s join faculty f on s.faculty_id = f.id
where s.schoolarship >=100000 and s.schoolarship <=300000
group by s.faculty_id,f.name
having count(s.id)>=2;

-- 17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t
select *from student
where schoolarship =(select max(schoolarship) from student);

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02
select * from student
where hometown='H� N?i' and EXTRACT(month FROM birthday)=2;

-- 2. Sinh vi�n c� tu?i l?n h?n 20
select * from student
where EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)>20;

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990
SELECT * FROM student
where  EXTRACT(YEAR from birthday)=1990 and EXTRACT(month from birthday) between 1 and 3;

-------------------------------------------------------------------

/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�
select f.name,s.id "M� sinh vi�n", s.name
from faculty f join student s on f.id=s.faculty_id
where f.name like 'Anh - V?n' or f.name like 'V?t l�';

-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C
select f.name, s.id "M� sinh vi�n", s.name, s.gender
from faculty f join student s on f.id= s.faculty_id
where ( f.name like 'Anh - V?n' or f.name like 'V?t l�' ) and s.gender = 'Nam';

-- 3. Cho bi?t sinh vi�n n�o c� ?i?m thi l?n 1 m�n c? s? d? li?u cao nh?t
select s.id,s.name,exm.mark
from student s join exam_management exm on s.id = exm.student_id
JOIN subject sb on sb.id = exm.student_id
where exm.number_of_exam_taking = 1 and exm.mark = (
select max(mark) from exam_management ex join subject su on su.id = ex.subject_id
where su.name like 'C? s? d? li?u');
                                        
-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.
select f.name "T�n khoa", s.id "m� sv", s.name "T�n SV"
from student s join faculty f on s.faculty_id = f.id
where f.name in ('Anh - V?n') and s.birthday = ( select max(s.birthday)
from student);

-- 5. Cho bi?t khoa n�o c� ?�ng sinh vi�n nh?t
with a as (
    select count(*) AS "SO_LUONG"
    from student s
    join faculty f on s.faculty_id = f.id
    group by f.name
)
select ff.name, count(*) as "S? L??NG"
from student ss
join faculty ff on ss.faculty_id = ff.id
group by ff.name
having count(*) = (select max(so_luong)
from a);
-- 6. Cho bi?t khoa n�o c� ?�ng n? nh?t
with a as (
    select f.name, count(*) as "SO_LUONG"
    from student s
    join faculty f on s.faculty_id = f.id
    where s.gender = 'N?'
    group by f.name
    order by "SO_LUONG" desc
)
select name,SO_LUONG
from a
where "SO_LUONG" = (select max(SO_LUONG) from a);

-- 7. Cho bi?t nh?ng sinh vi�n ??t ?i?m cao nh?t trong t?ng m�n


-- 8. Cho bi?t nh?ng khoa kh�ng c� sinh vi�n h?c

-- 9. Cho bi?t sinh vi�n ch?a thi m�n c? s? d? li?u

-- 10. Cho bi?t sinh vi�n n�o kh�ng thi l?n 1 m� c� d? thi l?n 2