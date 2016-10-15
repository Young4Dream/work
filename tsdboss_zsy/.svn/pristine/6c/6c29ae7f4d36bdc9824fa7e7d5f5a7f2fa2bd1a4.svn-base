select * from yhdang;
select * from sys_user;
SELECT * FROM t112_pxsg;

select  * from rb_field where table_name='hthhf' ;--Sgrq 受理日期    Pxsj 派单时间

SELECT c.*
FROM (SELECT ROWNUM R,B.* 
		FROM ( SELECT * FROM t112_pxsg where 1=1  order by Sgrq desc)B 
		WHERE ROWNUM <= 0 + 30) C 
WHERE C.R > 0;

select nvl(round(Wgrq-Sgrq)*24,0) lssj from t112_pxsg;
select sgrq,wgrq from t112_pxsg;

select * from hthhf;

select * from user_check;

select xdh,sgnr from teljob ;

select * from per_storedprocedure where sshowname='';

select * from air_route_phone_his;

select * from yhdang_old;

select * from air_users;

select  * from rb_field where table_name='air_users'; 

select '用户地址',Yhdz,'',100 as routeno from yhdang_old where dh='10000017'  and opertype ='update' order by opertime desc ;

select * from (select rownum rn,* from yhdang_old y)  where y.rn>0 ;

SELECT '用户地址',Yhdz,'',100 as routeno FROM ( SELECT A.*, ROWNUM RN FROM (SELECT * FROM yhdang_old where dh='10000017'  and opertype ='update' order by opertime desc) A WHERE ROWNUM <= 1 ) WHERE RN >= 0 ;

select d.devname name1,replace(c.devname||'('||c.ip||')','()','') name2,b.devname name3,a.routeno from air_route_phone a, air_device_detail b, air_device_detail c, air_device_master d, air_device_detail e where a.dh='10000017' and a.lineno=1 and a.portno = b.devno and substr(a.portno,1, 13) = c.devno and substr(a.portno,1, 20) = e.devno and substr(a.portno,1, 6) = d.devno union select '用户地址',useraddr,'',100 as routeno from air_users where dh='10000017' and linenum=1 union select '用户地址',useraddr,'',100 as routeno from air_usersbj where dh='10000017' and linenum=1 order by routeno

select lineno,dh from air_route_phone_his where dh = '86845701';
select * from air_route_phone_his;

select * from Dhyw_WaitCtl;

select * from air_route_phone_his;

select * from  air_device_detail;
update  air_device_detail set state='free' ,dh='' where dh='86845355';

select * from hthhf where byye_ysk >100 and hzyf='201508';

select * from mxmonth;
insert into mxmonth values('201510',to_date('2015-10-01 00:00:00','yyyy-mm-dd hh24:mi:ss'),to_date('2015-11-01 00:00:00','yyyy-mm-dd hh24:mi:ss'));

select * from hthhf where dh='86841667' order by hzyf desc;

select * from hthhf order by hzyf desc;

select * from hthhf where hzyf='201509' and hth='S007779';

select * from Hthhf_Hz order by hzsj desc;

select * from Hthhf_Hz where hzyf='201509' and hth='S007779';

select * from huizong order by hzyf desc;S007779

select * from huizong where hzyf='201509' and hth='S007779'; 

SELECT * FROM Call_Type_Num;

select Field_Name,Field_Alias,DataType,ShowWidth from rb_field where lower(table_name)=lower('vw_teljobhistory') and Field_Alias is not null and WebSelectable='T' order by showorder asc;

select * from vw_TelJobHistory;

SELECT * FROM air_device_master;--号线设备

SELECT * FROM air_routedefine;--号线设备

SELECT * FROM vw_air_users_dhkd;--号线设备
select  * from rb_field where table_name=''; 
