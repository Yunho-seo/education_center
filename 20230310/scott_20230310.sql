# �μ���ȣ�� 10���� ����� ���� ������ ���
select * from emp where deptno = 10;

# �޿��� 2000 �̻��� ��� ���
select * from emp where sal >= 2000;

# hiredate�� '1982/01/01' ���� ū ����� ename, hiredate�� ���
select ename, hiredate from emp where hiredate > '1982/01/01';

# ��� �̸��� SCOTT�� ����� �����ȣ, ����̸�, �޿��� ���
select empno, ename, sal from emp where ename='SCOTT';

# Job�� 'CLERK'�̰� �μ���ȣ�� 10�� ������ ���
select * from emp where job='CLERK' and deptno=10;

# �Ի����� '1982/01/01'�� ���� �̰ų� job�� 'MANAGER'�� ������ ���
select * from emp where hiredate>'1982/01/01' or job='MANAGER';

# �μ���ȣ�� 10�� �ƴ� ������ ���
select * from emp where deptno <> 10;

# �޿��� 2000���� 3000 ���� �޿��� �޴� ��� ���
select ename from emp where sal between 2000 and 3000;
select * from emp where sal between 2000 and 3000;

# Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ��� ���
select * from emp where comm=300 or comm=500 or comm=1400;
select * from emp where comm in(300, 500, 1400);

# 7521�̰ų� 7654�̰ų� 7844�� ������� �����ȣ�� �޿��� �˻��ϴ� ������ �ۼ� (�񱳿����ڿ� OR ������ �ۼ�)
select empno, sal from emp where empno=7521 or empno=7654 or empno=7844;

# 1987�⿡ �Ի��� ����� BETWEEN AND �����ڸ� �̿��Ͽ� ���
select ename from emp where between '1987/1/1' and '1987/12/31';

# Ŀ�̼��� 300�� �ƴϰų� 500�� �ƴϰų� 1400�� �ƴ� ��� ���
select * from emp where comm!=300 and comm!=500 and comm!=1400;
select * from emp where comm not in(300, 500, 1400);

# ������̺��� ����� �� Ŀ�̼��� �޴� ������� ���
select count(comm) from emp;

# ������ ���� ����, �� �ߺ����� �ʴ� ������ ������ ī��Ʈ�Ͽ� ���
select count(distinct job) from emp;        -- ������ ������ -> ����

select * from dept;
select * from emp;

# �μ��� ��� �޿��� ���
select deptno, avg(sal) from emp group by deptno;

# �Ҽ� �μ��� �ִ�޿��� �ּұ޿��� ���
select deptno, max(sal), min(sal) from emp group by deptno;

# �������� �׷�ȭ�Ͽ� ����, �ο���, ��ձ޿�, �ְ� �޿���, ���� �޿��� �� �հ踦 ���
select job, count(job), avg(sal), max(sal), min(sal), sum(sal) from emp group by job;
select job, count(*) as �ο���, avg(sal), max(sal), min(sal), sum(sal) from emp group by job;

# ���� : 1000 �̻��� �޿��� �������ִ� ����鿡 ���ؼ��� �μ����� ����� ���� �� ������
#       �μ��� ��ձ޿��� 2000 �̻��� �μ���ȣ�� �μ��� ��� �޿��� ���
select deptno, avg(sal) from emp where sal>1000 group by deptno having avg(sal) >= 2000;

# �μ��� �޿��� �ִ밪�� �ּҰ��� ���ϵ� �ִ�޿��� 2900 �̻��� �μ��� ���
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 2900;

# ��ü ������ 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ ���޿� �հ踦 ���
# (�� �Ǹſ��� �����ϰ� �� �޿� �հ�� �������� ����)
-- ���տ���
select job, sum(sal) from emp where job not in('SALESMAN') group by job having sum(sal) > 5000 order by sum(sal) desc;


# �μ����� ���� �޿��� ���̹޴� ����� �����ȣ, �̸�, �޿�, �μ���ȣ�� ���
# 4��
select empno, ename, sal, deptno from emp where concat(sal, deptno) in(select concat(max(sal), deptno) from emp group by deptno);      # (deptno 20�� �θ� ����)

# SCOTT�� ������ ������ ���� ����� ���
# "" : ���̺��̳� ��ü�� ǥ��, ���ڿ��� ǥ���� ������ ''
select * from emp where job = (select job from emp where ename = 'SCOTT');

# SCOTT�� �޿��� �����ϰų� �� ���̹޴� ����̸��� �޿��� ���
SELECT ename, sal FROM emp WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

# �޿��� 20�μ��� ��� �޿����� ũ��, ����� �����ϴ� ������μ� 20�μ��� ������ �ʴ� ��� ������ ���
select * from emp where sal > (select avg(sal) from emp where deptno = 20) and deptno != 20;
select * from emp where sal > (select avg(sal) from emp group by deptno having deptno=20) and empno in (select distinct mgr from emp) and deptno != 20;

# 10�� �μ��� �ٹ��ϴ� ����� �̸��� 10�� �μ��� �μ����� ���
select e.ename, d.dname from emp e, (select deptno, dname from dept where deptno=10) d where e.deptno = d.deptno;

# ������� 5�� �̻� �μ��� �μ���� ��� ���� ���
select d.deptno, count(empno) from emp e join dept d on group by d.deptno=e.deptno having count(empno) >= 5;
select d.dname, count(e.empno) from emp e, dept d where e.deptno=d.deptno
 group by d.dname having count(e.empno) >= 5;

select dname, count(e.empno) from emp e join dept d on e.deptno=d.deptno group by d.dname having count(e.empno)>=5;

# SCOTT�� ����� �μ����� ���
SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'SCOTT';
select dname from emp e, dept d where e.deptno=d.deptno and e.ename='SCOTT';
select dname from emp e join dept d on e.deptno=d.deptno where e.ename='SCOTT';

select round(42.195, 2);    # mariaDB������ ��� ��
select round(42.195, 2) from dual;  # �Ҽ��� �Ʒ� ��°�ڸ� �ݿø�
select round(42.195, -1) from dual;

# ���� : emp�� sal�� 100���� ������ ����
select mod(sal, 100) from emp;

select -10, abs(-10) from dual;         # abs : ���밪
select ename, length(ename) from emp;   # �����(ename)�� ����
select lpad('1234', 20, '*') from dual;
select sysdate from dual;               # ���� ��¥
select sysdate, hiredate, months_between(sysdate, hiredate) from emp;
select hiredate, add_months(hiredate, 6) from emp;
select last_day(hiredate) from emp;     # �Ի����� ������

# ��ȯ�Լ� ( mariadb������ casting�� ��� )
select ename, to_char(sal, '$999,999') from emp;

# ���� ������ (if(����, ��, ����);
select ename, deptno, decode(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 
                     'SALES', 40, 'OPERATIONS') from emp;
select ename, deptno,
    case when deptno=10 then 'ACCOUNTING'
         when deptno=20 then 'RESEARCH'
         when deptno=30 then 'SALES'
         when deptno=40 then 'OPERATIONS'
     end case
from emp;

# �������� : JOB���� Bonus�� �޿��� 1.5, 1.6, 1.7, 1.8�� ������ �ַ��� �Ѵ�.
# JOB�� ������ Ȯ���ϰ� JOB�� ������������ �����Ͽ� 1.5�踦 �������� 0.1�� �����ϸ鼭 ���� ���ʽ��� ���
select distinct job from emp order by job;
select ename, deptno, 
    case when job= 'ANALYST'   then sal*1.5
         when job= 'CLERK'     then sal*1.6
         when job= 'MANAGER'   then sal*1.7
         when job= 'PRESIDENT' then sal*1.8
         when job= 'SALESMAN'  then sal*1.9
    end as ���ʽ��޿�
from emp order by job;


# ���̺� ����
# ���̺�� �������� : constraint�� ���̴� ��� �ݵ�� �̸��� �־�� ��
create table dept2(
    deptno number constraint dept_pk_deptno primary key, -- �ڵ� �ο�
    dname varchar2(40),
    loc varchar2(50)
);
select * from dept2;
drop table dept2;

insert into dept2 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept2 values(20, 'RESERCH', 'DALLAS');
insert into dept2 values(30, 'SALES', 'CHICAGO');
insert into dept2 values(40, 'OPERATIONS', 'BOSTON');

create table emp10(
    empno number(4)     constraint emp10_empno_pk primary key,
    ename varchar2(10)  constraint emp10_ename_nn not null,
    sal number(7,2)     constraint emp10_sal_ck check(sal between 500 and 5000),
    gender varchar2(1)  constraint emp10_gender_ck check (gender in('M', 'F'))
);
select * from emp10;
drop table emp10;

insert into emp10(empno, ename, sal, gender) values (123, '���γ�', 1000, 'M');
insert into emp10(empno, ename, sal, gender) values (124, '���ֿ�', 6000, 'F');
insert into emp10(empno, ename, sal, gender) values (125, '������', 1000, 'M');

alter table emp10 drop constraint emp10_sal_ck;

# �������� ����
alter table emp10 add constraint emp10_sal_ck check (sal>=500 and sal<=7000);

select count(*) from emp10;
insert into emp10 values(null, null, 'SALESMAN', 101);      # ename�� NOT NULL�̶� ���� �Ұ�
insert into emp10 values(null, '������', 'SALESMAN', 101);   # primary key�� �ߺ� X, NULL ��� X
                                                            # Unique key�� �ߺ� X, NULL ���

# ���� : mariadb���� �ߴ� school�� sungjuk ���̺��� �����ϱ�
# primary / foreign key�� ����
create table school(
    no number(4) constraint school_no_nn NOT NULL,
    schoolname varchar2(50),
    address varchar2(50),
    schoolcode char(10) constraint school_schoolcode_pk primary key,
    studentcount number(4)
);
select * from school;
drop table school;


create table sungjuk(
    no number(3) constraint sungjuk_no_pk primary key,
    name varchar2(20) not null,
    kor number(3) constraint sungjuk_kor_ck check(kor between 0 and 100),
    mat number(3) constraint sungjuk_mat_ck check(mat between 0 and 100),
    eng number(3) constraint sungjuk_eng_ck check(eng between 0 and 100),
    total number(4),
    average number(5, 2),
    grade char(1),
    schoolcode char(10) constraint sungjuk_schoolcode_fk references school(schoolcode)
);
select * from sungjuk;
drop table sungjuk;

create sequence school_no_seq increment by 1 start with 1;
create sequence student_no_seq increment by 1 start with 1;
-- query���� ��ȣ�� �������Ѱ��鼭 �Է��� �ؾ� �Ѵ�.

INSERT INTO school(no, schoolname, address, schoolcode, studentcount) 
    VALUES(school_no_seq.NEXTVAL, '���ֿ��ڰ���б�', '���ֽ�', 'CH00000001', 360);
INSERT INTO school(no, schoolname, address, schoolcode, studentcount)
    VALUES(school_no_seq.NEXTVAL, '���￩�ڰ���б�', '�����', 'SE00000001', 1200);
INSERT INTO school(no, schoolname, address, schoolcode, studentcount) 
    VALUES(school_no_seq.NEXTVAL, '��������б�', '������', 'IC00000001', 560);

INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '�踸��', 100, 99, 99, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '�����', 100, 99, 99, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '������', 81, 81, 81, 'SE00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '������', 81, 81, 81, 'SE00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '������', 91, 100, 100, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '������', 100, 100, 100, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '���α�', 100, 81, 71, 'IC00000001');



# �̸��� �������� �л��� �б�, ��, �л��̸�, ����, ��� ���
select s.schoolname, sj.no, sj.name, sj.kor+sj.mat+sj.eng as ����, round((sj.kor+sj.mat+sj.eng)/3, 2) as ���
 from school s join sungjuk sj on s.schoolcode=sj.schoolcode where sj.name='������';

# ������ �ֿ���� �л��� ���� ���
select * from school s join sungjuk sj on s.schoolcode=sj.schoolcode 
    where sj.kor+sj.mat+sj.eng = (select max(kor+mat+eng) from sungjuk);

# �б��� �л����� ��������� ���
select s.schoolname, count(sj.no) as �л���, round(avg(sj.kor+sj.mat+sj.eng), 2) as �������
    from school s join sungjuk sj on s.schoolcode = sj.schoolcode group by s.schoolname;

# �б��� ����� �л��� �Ѹ� �����Ͽ� �̸�, ����, �б� �̸� ���
select sj.name, sj.kor+sj.mat+sj.eng as ����, s.schoolname 
    from school s, sungjuk sj 
    where s.schoolcode=sj.schoolcode and (sj.kor+sj.mat+sj.eng) in (select max(kor+mat+eng) from sungjuk group by schoolcode);
