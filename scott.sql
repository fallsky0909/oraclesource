--SCOTT

--EMP(employee) 테이블 구성 보기 DESC(describe)
--필드명(열이름)      제약조건      데이터타입
--EMPNO(사원번호)     NOT NULL     NUMBER(4)
--ENAME(사원명),JOB(직책),MGR(직속상관 번호),HIREDATE(입사일),SAL(급여),COMM(수당),DEPTNO(부서번호)
--NUMBER : 숫자(소수점 자릿수 포함해서 지정 가능) / NUMBER(4) : 4자리 숫자까지 허용 / NUMBER(8,2) : 전체 자릿수 8, 소수점 2자리까지
--VARCHAR2 : 가변형 문자열 저장 / VARCHAR2(10) : 10byte 문자까지 저장 가능
--DATE : 날짜 데이터
DESC EMP;

--DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC DEPT;

--GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
DESC SALGRADE;

--select : 데이터 조회
--조회 방식 : 셀력션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)
--SELECT 열이름1, 열이름2... (조회할 열이 전체라면 * 로 처리)
--FROM 테이블명;

--1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

--단축키 : ctrl + F7 = 전체 내용 정렬(엔터 쳐줌)
SELECT
    *
FROM
    emp;
    
--3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;

--4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
    
--5. EMP 테이블 안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
    
--6. EMP 테이블 안에 부서번호 조회(단, 중복된 부서번호는 제거)
--DISTINCT : 중복 제거
SELECT DISTINCT
    deptno
FROM
    emp;

-- 열이 여러개인 경우(묶어서 중복이냐 아니냐를 판단 : manager 30, manager 20, manager 10은 서로 중복이 아님)
SELECT DISTINCT
    job,
    deptno
FROM
    emp;
    
--7. 연산
-- 사원들의 1년 연봉 구하기(SAL * 12 + COMM)
-- as 필드명 : 필드명 지정(as 생략 가능)
SELECT
    empno,
    ename,
    sal * 12 + comm AS 연봉
FROM
    emp;

SELECT
    empno           사원번호,
    ename           직책,
    sal * 12 + comm 연봉
FROM
    emp;
--필드명 중간에 공백이 있다면 ""로 묶어줘야함(안 묶으면 키워드가 있어야하는 위치에 없다면서 오류)
SELECT
    empno           사원번호,
    ename           "직 책",
    sal * 12 + comm 연봉
FROM
    emp;
    
--8. 정렬 : ORDER BY
--          내림차순 => DESC, 오름차순 ASC (DESCENDING, ASCENDING)

--ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
--추출경로 order by 정렬기준 내림/오름;
    emp
ORDER BY
    sal DESC;
    
--ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬
SELECT
    ename,
    sal
FROM
--기본이 asc이기 때문에 asc는 생략 가능
    emp
ORDER BY
    sal ASC;
    
--전체 내용 출력, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno;
    
--전체 내용 출력, 결과가 부서번의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno,
    sal DESC;
    
-- [실습] emp 테이블의 모든 열 출력
-- empno => employee_no
-- ename => employee_name
-- mgr => manager
-- sal => salary
-- comm => commission
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순으로 정렬
-- 부서번호가 같다면 사원 이름을 기준으로 오름차순 정렬

SELECT
    empno  employee_no,
    ename  employee_name,
    mgr    manager,
    sal    salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename;
    
-- WHERE : 특정 조건을 기준으로 원하는 행을 조회 / 대소문자는 ''로 씌워야함 / 대소문자 구별함 / 조건이 여러개인 경우 AND, OR로 연결 

-- 부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30; -- = : 같다

-- 사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
-- 부서번호가 30이고, 사원직책이 SALESMAN인 정보 조회 
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';
    
-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;

-- 부서번호가 30이거나, 사원직책이 CLERK 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';

-- 산술연산자 : +, -, *, /
-- 비교연산자 : >, >=, <, <=
-- 등가비교연산자 : =,!=, <>, ^= (!=, <>, ^= : A값과 B값이 다를 경우 TRUE, 같을 경우 FALSE)
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자
-- LIKE 연산자와 와일드카드(_, %)
-- IS NULL 연산자
-- 집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

-- 연산자 우선순위
-- 1)산술연산자 *, /
-- 2)산술연산자 +, -
-- 3)비교연산자
-- 4)IS NULL, IS NOT NULL, LIKE, NOT LIKE, IN, NOT IN
-- 5) BETWEEN A AND B
-- 6) NOT
-- 7) AND
-- 8) OR
-- 우선순위를 줘야 한다면 소괄호 사용 추천

-- EMP 테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;

-- ENAME 이 F 이후의 문자로 시작하는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

SELECT
    *
FROM
    emp
WHERE
    ename <= 'FORZ';

-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

-- SAL 이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000; -- = not sal =3000;

-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회 => IN 연산자

SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- JOB이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job != 'SALESMAN'
    AND job != 'CLERK';

-- JOB이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회 => IN 연산자

SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
-- 부서번호가 10,20 인 사원 조회(in 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );
    
-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;

-- LIKE

-- 사원 이름에 S로 시작하는 사원만 조회
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

-- 사원 이름 두번째 글자가 A 인 사원만 조회
SELECT * FROM EMP WHERE ENAME LIKE '_A%'

-- 사원 이름 세번째 글자가 D 인 사원만 조회
SELECT * FROM EMP WHERE ENAME LIKE '__D%'

-- 사원 이름에 AM 이 포함된 사원만 조회
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM 이 포함되지 않은 사원만 조회
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- NULL : 데이터 값이 조회되지 않는 상태 / NULL 이 연산자에 들어가면 값이 NULL이 나온다(COMM = NULL 일때, SAL*12+COMM=NULL)
-- '=' 을 사용할 수 없음 IS로 대체

-- COMM 이 NULL 인 사원 조회
SELECT *
FROM EMP;
WHERE COMM IS NULL;

-- MGR 이 NULL인 사원 조회
SELECT * FROM EMP WHERE MGR IS NULL;

-- MGR 이 NULL이 아닌 사원 조회
SELECT * FROM EMP WHERE MGR IS NOT NULL;

-- 집합연산자

-- UNION(동일한 결과값인 경우 중복 제거), UNION ALL(중복 제거 안함) : 합집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- MINUS(차집합)
SELECT EMPNO, ENAME, SAL DEPTNO
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- INTERSECT(교집합)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

-- EMP 테이블에서 사원이름이 S로 끝나는 사원 데이터 조회
SELECT * FROM EMP WHERE ENAME LIKE '%S';

-- EMP 테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의
-- 사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT EMPNO, ENAME, SAL FROM EMP WHERE DEPTNO=30 AND JOB='SALESMAN';

-- EMP 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
-- 집합연산자를 사용하는 방식과 사용하지 않는 방식 두 가지를 사용한다
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO IN(20,30) AND SAL>2000;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO=20 AND SAL>2000
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO=30 AND SAL>2000;

-- 사원 이름에 E가 포함되어 있는 30번 부서 사원중 급여가 1000~2000 사이가 아닌 사원
-- 이름, 사원번호, 급여, 부서번호를 조회하기
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP WHERE ENAME LIKE '%E%' AND DEPTNO=30 AND SAL BETWEEN 1000 AND 2000;

-- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원 이름의
-- 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT * FROM EMP WHERE (COMM IS NULL OR COMM='') AND MGR IS NOT NULL AND JOB IN('MANAGER', 'CLERK') AND ENAME NOT LIKE '_L%';

-- 오라클 함수
-- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

-- 1. 문자열 함수
-- 1) UPPER, LOWER, INITCAP
-- UPPER : 모두 대문자, LOWER : 모두 소문자, INITCAP : 첫글자만 대문자
-- LIKE '%ORACLE%' OR LIKE '%oracle%' OR LIKE '%Oracle%' => 검색 시 사용
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;

SELECT * FROM EMP WHERE UPPER(ENAME) = 'FORD';

SELECT * FROM EMP WHERE UPPER(ENAME) LIKE UPPER('%ford%');

-- 2) LENGTH : 문자열 길이
SELECT ENAME, LENGTH(ENAME) FROM EMP;

-- 사원 이름의 길이가 5 이상인 사원 조회
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5;

-- 한글일 때
-- dual : sys가 소유하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1=>1byte, 한글 : 문자1=>3byte
SELECT LENGTH('한글'), LENGTHB('한글'),LENGTHB('AB') FROM DUAL;

-- 3) SUBSTR(문자열 데이터, 시작위치, 추출길이) : 추출길이 생략 가능
--      문자열 일부 추출
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5), SUBSTR(JOB, -3)
FROM EMP;

-- ENAME, 세번째 글자부터 출력
SELECT ENAME, SUBSTR(ENAME, 3) FROM EMP;

-- 3) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
-- INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택사항), 시작위치에서 찾으려는 문자가 몇번째인지 지정(선택사항))

-- HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM DUAL;

-- REPLACE : 특정 문자를 다른 문자로 변경
-- REPLACE(문자열 데이터, 찾는 문자, 변경 문자(선택사항))

-- 010-1234-5678 - 를 빈 문자열로 변경 / -를 없애기
SELECT '010-1234-5678' AS 변경전, REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1, REPLACE('010-1234-5678', '-') AS REPLACE_2
FROM DUAL;

-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT '이것이 Oracle 이다' AS 변경전, REPLACE ('이것이 Oracle 이다', '이것이', 'This is') FROM DUAL;

-- 5) CONCAT : 두 문자열 데이터 합치기
SELECT CONCAT (EMPNO, ENAME) FROM EMP;

SELECT CONCAT (EMPNO, CONCAT(' : ', ENAME)) FROM EMP;

-- || : 문자열 연결 연산자
SELECT EMPNO || ENAME, EMPNO || ' : ' || ENAME FROM EMP;

-- 6) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거
-- ' ORACLE' = 'ORACLE' => FALSE (공백도 문자로 취급)

SELECT '        이것이            ', TRIM(         '이것이'         ) FROM DUAL;