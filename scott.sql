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
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

-- LIKE

-- 사원 이름에 S로 시작하는 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';

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
FROM
dual;

-- REPLACE : 특정 문자를 다른 문자로 변경
-- REPLACE(문자열 데이터, 찾는 문자, 변경 문자(선택사항))

-- 010-1234-5678 - 를 빈 문자열로 변경 / -를 없애기
SELECT
    '010-1234-5678'                    AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace_1,
    replace('010-1234-5678', '-')      AS replace_2
FROM
    dual;

-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT
    '이것이 Oracle 이다' AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is')
FROM
    dual;

-- 5) CONCAT : 두 문자열 데이터 합치기
SELECT
    concat(empno, ename)
FROM
    emp;

SELECT
    concat(empno,
           concat(' : ', ename))
FROM
    emp;

-- || : 문자열 연결 연산자
SELECT
    empno || ename,
    empno || ' : '
             || ename
FROM
    emp;

-- 6) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거
-- ' ORACLE' = 'ORACLE' => FALSE (공백도 문자로 취급)
SELECT
    '        이것이            ',
    TRIM('이것이')
FROM
    dual;
    
-- 2. 숫자함수
-- 1) ROUND, TRUNC, CEIL, FLOOR, MOD

-- round : 반올림
-- round(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round, -- 소수점 첫째 자리에서 반올림
    round(1234.5768, 0)   AS round0, -- 소수점 첫째 자리에서 반올림
    round(1234.5768, 1)   AS round1, -- 소수점 둘째 자리에서 반올림
    round(1234.5768, 2)   AS round2, -- 소수점 셋째 자리에서 반올림
    round(1234.5768, - 1) AS round_minus1, -- 일의 자리에서 반올림
    round(1234.5768, - 2) AS round_minus2 -- 십의 자리에서 반올림
FROM
    dual;

-- trunc : 특정 위치에서 버리는 함수
-- trunc(숫자, 버리는 위치(선택))
SELECT
    trunc(1234.5678)      AS trunc, -- 소수점 첫째 자리에서 버림
    trunc(1234.5768, 0)   AS trunc0, -- 소수점 첫째 자리에서 버림
    trunc(1234.5768, 1)   AS trunc1, -- 소수점 둘째 자리에서 버림
    trunc(1234.5768, 2)   AS trunc2, -- 소수점 셋째 자리에서 버림
    trunc(1234.5768, - 1) AS trunc_minus1, -- 일의 자리에서 버림
    trunc(1234.5768, - 2) AS trunc_minus2 -- 십의 자리에서 버림
FROM
    dual;
    
-- ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수
SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;
    
-- mod(숫자, 나눌 수) : 나머지 값
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;

    
-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 연산불가

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 yesterday,
    sysdate + 1 tomorrow
FROM
    dual;

-- 2) ADD_MONTHS(날짜, 더할 개월 수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

-- 입사 50주년이 되는 날짜 구하기
-- empno, ename, hiredate, 입사50주년 날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;

-- 3) MONTHS_BETWEEN(첫번째 날짜, 두번째 날짜) : 두 날짜 데이터 간의 날짜 차이를 개월 수로 계산하여 출력

-- 입사 45년 미만인 사원 데이터 조회
-- empno, ename, hirdate
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
-- 4) NEXT_DAY(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--    LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

-- 날짜의 반올림, 버림 : ROUND, TRUNC
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용
--      2023년인 경우 2050이하 이므로 2001년으로 처리

SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;
    
-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

--ORA-01722: 수치가 부적합합니다
--01722. 00000 -  "invalid number"
--SELECT EMPNO, ENAME, 'ABDC'+EMPNO
--FROM EMP
--WHERE ENAME = 'FORD';

-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력 형태로 날짜 출력하기 TO_CHAR 주로 사용됨
SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;

-- MON, MONTH : 월 이름
-- DDD : 365일 중에서 며칠
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')     AS 현재날짜,
    to_char(sysdate, 'YYYY')           AS 현재연도,
    to_char(sysdate, 'MM')             AS 현재월,
    to_char(sysdate, 'MON')            AS 현재월1,
    to_char(sysdate, 'MONTH')          AS 현재월2,
    to_char(sysdate, 'DD')             AS 현재일자,
    to_char(sysdate, 'DDD')            AS 현재일자2,
    to_char(sysdate, 'AM HH12:MI:SS ') AS 현재시간
FROM
    dual;

-- TO_NUMBER(문자열 데이터, 인식될 숫자형태)

-- 자동 형변환
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

-- 자동 형변환 안되는 상황 - ',' 들어가면 문자로 인식되기 때문에 형변환 시켜줘야함
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

-- SAL 필드에 ',' 나 통화($) 표시를 하고 싶다면?
-- L(Local) 지역 화폐단위 기호를 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;

--TO_DATE(문자열 데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20180714', 'YYYY-MM-DD')   AS todate2
FROM
    dual;

--ORA-01722: 수치가 부적합합니다
--SELECT '2023-03-21' - '2023-02-01'
--FROM DUAL;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;

-- 널처리 함수
-- NULL + 300 => NULL

-- NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + nvl(comm, 0)
FROM
    emp;

--NVL2(데이터, 널이 아닐경우 반환할 데이터 A, 널일 경우 반환할 데이터 B) - A,B는 같은 타입이여야함
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;

-- DECODE 함수 / CASE 문
-- DECODE(검사 대상이 될 데이터, 
--        조건1, 조건1이 일치할 때 실행할 구문,
--        조건2, 조건2가 일치할 때 실행할 구문,
--        ...
--        일치하는 조건이 없을때 실행할 구문)

-- EMP 테이블에 직책이 MANAGER 인 사람은 급여의 10%인상,
-- SALESMAN 인 사람은 5%, ANALYST 인 사람은 그대로, 나머지는 3% 인상된 급여 출력
SELECT 
    EMPNO, 
    ENAME, 
    JOB, 
    SAL, 
    DECODE(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05, 'ANALYST', sal, sal * 1.03) UPSAL
FROM 
    EMP;
    
-- CASE 문 : DECODE와 같은 역할, 
SELECT 
    EMPNO, 
    ENAME, 
    JOB, 
    SAL, 
    CASE job
    WHEN 'MANAGER' THEN sal * 1.1
    WHEN 'SALESMAN' THEN sal * 1.05
    WHEN 'ANALYST'THEN sal
    ELSE sal * 1.03
    END UPSAL
FROM 
    EMP;
    
SELECT 
    EMPNO, 
    ENAME, 
    JOB, 
    SAL, 
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
        END AS COMM_TEXT
FROM EMP;

--[실습1]
SELECT EMPNO, ENAME, SAL, TRUNC(SAL/21.5, 2) DAY_PAY, ROUND((SAL/21.5)/8, 1) TIME_PAY
FROM EMP;

--[실습2]
SELECT EMPNO, ENAME, HIREDATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3) ,'월요일'), 'YYYY-MM-DD') R_JOB, NVL2(COMM, TO_CHAR(COMM),'N/A') COMM
FROM EMP;

--[실습3]
SELECT EMPNO, ENAME, MGR, 
CASE
WHEN mgr IS NULL THEN '0000'
WHEN SUBSTR(TO_CHAR(MGR), 1, 2)='75' THEN '5555'
WHEN SUBSTR(TO_CHAR(MGR), 1, 2)='76' THEN '6666'
WHEN SUBSTR(TO_CHAR(MGR), 1, 2)='77' THEN '7777'
WHEN SUBSTR(TO_CHAR(MGR), 1, 2)='78' THEN '8888'
else to_char(mgr)
END AS CHG_MGR
FROM EMP;

SELECT EMPNO, ENAME, MGR,
DECODE(
    substr(to_char(mgr), 1, 2),
    null,
    '0000',
    '75',
    '5555',
    '76',
    '6666',
    '77',
    '7777',
    '78',
    '8888',
    substr(to_char(mgr),
           1)
) AS CHG_MGR
FROM
emp;

-- 다중행(집계) 함수 : SUM, COUNT, MAX, MIN, AVG

-- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--SELECT 
--    ename,
--    sum (sal)
--FROM 
--    EMP;
SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;
    
-- SUM() : NULL 은 제외하고 합계 구해줌
SELECT
    SUM(comm) --COMM에 NULL이 있음
FROM
    emp;

SELECT
    COUNT(sal)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp;

-- 부서번호가 20인 사원의 입사일 중 제일 최근 입사일
SELECT
    MAX(hiredate)
FROM
    emp
WHERE DEPTNO = 20;

-- 부서번호가 20인 사원의 입사일 중 제일 오래된 입사일
SELECT
    MIN(hiredate)
FROM
    emp
WHERE DEPTNO = 20;

SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;

-- GROUP BY : 결과 값을 원하는 열로 묶어 출력 / GROUP BY에 포함된 열만 SELECT 할 수 있다

-- 부서별 SAL 평균 구하기
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=10;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=20;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO=30;

SELECT AVG(SAL), DEPTNO, FROM EMP GROUP BY DEPTNO ORDER BY
deptno;

-- 부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;

--GROUP BY 표현식이 아닙니다. / DEPTNO와 AVG(SAL)이외는 SELECT에 들어올 수 없다
--SELECT
--    AVG(sal),
--    deptno,
--    ename
--FROM
--    emp
--GROUP BY
--    deptno;

-- GROUP BY + HAVING : GROUP BY 절에 조건을 줄 때
-- HAVING : 그룹화된 대상을 출력 제한 걸때 ( WHERE 쓰는거 아님! )

-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000 이상인 그룹만 출력)
-- DEPTNO, JOB, 평균
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

--ORA-00934: 그룹 함수는 허가되지 않습니다
--SELECT
--    deptno,
--    job,
--    AVG(sal)
--FROM
--    emp
--WHERE
--     AVG(sal) >= 2000
--GROUP BY
--    deptno,
--    job
--ORDER BY
--    deptno,
--    job;

-- WHERE 절과 HAVING절이 같이 올 경우 해석 순서
-- 1) FROM 구문 실행 2) WHERE 절 실행 3) GROUP BY 4) HAVING 5) SELECT 6) ORDER BY
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

-- [실습5]

-- 1)
SELECT
    deptno,
    trunc(AVG(sal),
          0) avg_sal,
    MAX(sal) max_sal,
    MIN(sal) min_sal,
    COUNT(*) AS CNT
FROM
    emp
GROUP BY
    deptno
ORDER BY
    deptno;
    
-- 2)
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(JOB) >= 3;
    
-- 3)
SELECT TO_CHAR(HIREDATE, 'YYYY') HIRE_YEAR, DEPTNO, COUNT(EMPNO) CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;