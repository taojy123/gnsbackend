-- MySQL dump 10.13  Distrib 5.7.26, for Win64 (x86_64)
--
-- Host: localhost    Database: gns_poc
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_info`
--

DROP TABLE IF EXISTS `acc_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_info` (
  `acctno` varchar(32) NOT NULL COMMENT '账户号',
  `kehhao` varchar(32) DEFAULT NULL COMMENT '客户号\r\n',
  `bal` decimal(36,4) DEFAULT NULL COMMENT '当前余额',
  `int_huoqi` decimal(36,4) DEFAULT NULL COMMENT '活期利息',
  `acctype` varchar(10) DEFAULT NULL COMMENT '账户类型',
  `bz` varchar(10) DEFAULT NULL COMMENT '币种',
  `kaihrq` datetime DEFAULT NULL COMMENT '开户日期',
  PRIMARY KEY (`acctno`),
  KEY `fk_kehhao` (`kehhao`),
  KEY `acctno` (`acctno`,`kehhao`),
  CONSTRAINT `fk_kehhao` FOREIGN KEY (`kehhao`) REFERENCES `user_info` (`kehhao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bal_info`
--

DROP TABLE IF EXISTS `bal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bal_info` (
  `acctno` varchar(32) NOT NULL COMMENT '账户号',
  `kehhao` varchar(32) DEFAULT NULL COMMENT '客户号',
  `lccpdm` varchar(20) DEFAULT NULL COMMENT '理财产品代码',
  `lcbal` decimal(32,4) DEFAULT NULL COMMENT '理财余额',
  `daoqr` datetime DEFAULT NULL COMMENT '到期日',
  PRIMARY KEY (`acctno`),
  KEY `fk_acctno` (`acctno`,`kehhao`),
  CONSTRAINT `fk_acctno` FOREIGN KEY (`acctno`, `kehhao`) REFERENCES `acc_info` (`acctno`, `kehhao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary`
--

DROP TABLE IF EXISTS `summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary` (
  `kehhao` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `fund_des` varchar(255) DEFAULT NULL,
  `out_cnt` varchar(255) DEFAULT NULL,
  `in_cnt` varchar(255) DEFAULT NULL,
  `in_amt` varchar(255) DEFAULT NULL,
  `bal_curr` varchar(255) DEFAULT NULL,
  `int_huoqi` varchar(255) DEFAULT NULL,
  `cnt_salmonth` varchar(255) DEFAULT NULL,
  `out_amt_lc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kehhao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sxj`
--

DROP TABLE IF EXISTS `sxj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sxj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kehhao` varchar(255) NOT NULL,
  `score` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=131071 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_summary`
--

DROP TABLE IF EXISTS `t_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_summary` (
  `kehhao` varchar(32) NOT NULL COMMENT '客户号id',
  `age` char(1) DEFAULT NULL COMMENT '年龄',
  `fund_des` char(1) DEFAULT NULL COMMENT '资金需求',
  `out_cnt` char(1) DEFAULT NULL COMMENT '月均出账次数',
  `in_cnt` char(1) DEFAULT NULL COMMENT '月均入账次数',
  `in_amt` char(1) DEFAULT NULL COMMENT '入账笔均金额',
  `bal_curr` char(1) DEFAULT NULL COMMENT '当前余额',
  `int_huoqi` char(1) DEFAULT NULL COMMENT '季活期利息金额',
  `cnt_salmonth` char(1) DEFAULT NULL COMMENT '代发月份数',
  `out_amt_lc` char(1) DEFAULT NULL COMMENT '理财资产',
  PRIMARY KEY (`kehhao`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tran_info`
--

DROP TABLE IF EXISTS `tran_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tran_info` (
  `jyseq` varchar(32) NOT NULL COMMENT '交易流水号',
  `acctno` varchar(32) DEFAULT NULL COMMENT '账户号',
  `kehhao` varchar(32) DEFAULT NULL COMMENT '客户号',
  `jyriq` datetime DEFAULT NULL COMMENT '交易日期',
  `jyjine` decimal(32,4) DEFAULT NULL COMMENT '交易金额',
  `bz` varchar(10) DEFAULT NULL COMMENT '币种',
  `jylx` varchar(10) DEFAULT NULL COMMENT '交易类型',
  `jyfx` char(1) DEFAULT NULL COMMENT '交易方向',
  PRIMARY KEY (`jyseq`) USING BTREE,
  KEY `fk_` (`acctno`,`kehhao`),
  CONSTRAINT `fk_` FOREIGN KEY (`acctno`, `kehhao`) REFERENCES `acc_info` (`acctno`, `kehhao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `kehhao` varchar(32) NOT NULL COMMENT '客户号',
  `zhjhao` varchar(32) DEFAULT NULL COMMENT '证件号',
  `salary` varchar(10) DEFAULT NULL COMMENT '月收入',
  PRIMARY KEY (`kehhao`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'gns_poc'
--
/*!50003 DROP PROCEDURE IF EXISTS `clean_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `clean_table`()
BEGIN

set  foreign_key_checks=0;

truncate   gns_poc.bal_info;

truncate   gns_poc.acc_info;

truncate   gns_poc.tran_info;

truncate   gns_poc.user_info;

set  foreign_key_checks=1;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_summary`()
BEGIN


		#清空旧表数据

		truncate table  summary;

		truncate table t_summary;

		truncate table sxj;


		# 数据源文件问题，这里做一次修改

	 	update tran_info set  jylx='DFA'  where  jyfx=0 and   jyseq in (select jyseq from (select jyseq from tran_info order by kehhao  desc  limit   100000 ) a)	;

		# 源文件空值替换


	 update user_info  set salary=null where salary like 'N_';

	 #写入年龄，客户号

   insert  into summary(kehhao,age)   select  kehhao, 2019-year(substr(zhjhao,7,8)) t from  user_info;

	 #写入资金需求

	 update summary s,

				(select   u.kehhao,round(sum(t.jyjine)/12/u.salary,2)  as sal from tran_info t, user_info u where

				u.kehhao=t.kehhao and t.jyriq>'2018-06-25'  and t.jyfx=1   group by u.kehhao)  a   

				set   s.fund_des=a.sal   where  a.kehhao=s.kehhao;

	 #写入月均出账次数

	 update  summary s,

				(select  kehhao,count(jyseq)/12 as out_cnt from  tran_info t 

				where t.jyriq>'2018-06-25' and t.jyfx=1  group  by t.kehhao) a

				set  s.out_cnt=a.out_cnt where a.kehhao=s.kehhao;

	 #写入月均入账次数		

	 update  summary s,

				(select  kehhao,count(jyseq)/12 as in_cnt from  tran_info t 

				where t.jyriq>'2018-06-25' and t.jyfx=0  group  by t.kehhao) a

				set  s.in_cnt=a.in_cnt where a.kehhao=s.kehhao;

	 #写入入账笔均金额		

	 update summary s,

				(select  kehhao,sum(jyjine)/count(jyjine) in_amt from  tran_info t 

				where t.jyriq>'2018-06-25' and t.jyfx=0  group by t.kehhao ) a

				set s.in_amt=a.in_amt where a.kehhao=s.kehhao;

	#写入当前余额		

	 update summary s,

				(select   kehhao,bal from  acc_info) a 

				set s.bal_curr=a.bal  where  a.kehhao=s.kehhao;

  #写入季活期利息金额

	 update summary s,

				(select   kehhao,int_huoqi from  acc_info) a 

				set s.int_huoqi=a.int_huoqi  where  a.kehhao=s.kehhao;

	#写入代发月份数		

	 update summary  s,

				(select  kehhao,count(*)  as cnt_salmonth  from  tran_info where  jyfx=0 and jylx='DFA'  group  by kehhao) a

				set s.cnt_salmonth=a.cnt_salmonth  where a.kehhao=s.kehhao;



	 #写入理财资产

	update summary s,

					(select  kehhao,lcbal from  bal_info) a 

					set s.out_amt_lc=a.lcbal  where  a.kehhao=s.kehhao;

				

	 #将临时表写入宽表，并转换为代码		

	 insert into  t_summary 

				select   kehhao, 

				case 1 when  age>=18 and age <=26 then 'A' when  27 <= age  and  age <=35 then 'B' when 36 <= age and  age <= 45 then 'C' 							when 	46 <= age and  age <= 55 then 'D' when age>55 then 'E' end ,

				case 1 when fund_des>1 then 'A' when fund_des>0.5 and fund_des<=1 then 'B'  

							when fund_des>=0 and fund_des<=0.5 then 'C' else 'D' end ,

				case 1 when out_cnt>=10 then 'A' when out_cnt>=1 and fund_des<10 then 'B'  

							when out_cnt>0 and out_cnt<1 then 'C' else 'D' end ,

				case 1 when in_cnt>=1 then 'A' when in_cnt>=0.2 and in_cnt<1 then 'B'  

							when in_cnt>0 and in_cnt<0.2 then 'C' else 'D' end ,

				case 1 when in_amt>=8000 then 'A' when in_amt>=2000 and in_amt<8000 then 'B'  

							when in_amt>0 and in_amt<2000 then 'C' else 'D' end ,

				case 1 when bal_curr>=1000 then 'A' when bal_curr>=100 and bal_curr<1000 then 'B'  

							when bal_curr>0 and bal_curr<100 then 'C' else 'D' end ,

				case 1 when int_huoqi>=1 then 'A' when int_huoqi>=0.1 and int_huoqi<1 then 'B'  

							when int_huoqi>0 and int_huoqi<0.1 then 'C' else 'D' end ,

				case 1 when cnt_salmonth>=12 then 'A' when cnt_salmonth>=6 and cnt_salmonth<=11 then 'B'  

							when cnt_salmonth>=1 and cnt_salmonth<=5 then 'C' else 'D' end ,

				case 1 when out_amt_lc>=300000 then 'A' when out_amt_lc>=60000 and out_amt_lc<300000 then 'B'  

							when out_amt_lc>1 and out_amt_lc<60000 then 'C' else 'D' end 

				from  summary;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_sxj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_sxj`()
BEGIN

insert into sxj(kehhao,score)

		select * from (select  kehhao,

		(case age  when 'A' then 31.27 when 'B' then 28.74  when  'C'  then  4.57 when  'D' then -112.69 when 'E' then -112.69 end  +

		case fund_des  when 'A' then -4.48  when 'B' then 0.24  when  'C'  then  -112.69 when  'D' then 1.13  end  +

		case out_cnt  when 'A' then 61.19 when 'B' then 35.95  when  'C'  then  6.00 when  'D' then -54.62  end  +

		case in_cnt  when 'A' then -2.94 when 'B' then -2.44  when  'C'  then  0.18 when  'D' then 4.41 end  +

		case in_amt  when 'A' then -23.82 when 'B' then 27.90  when  'C'  then 12.48 when  'D' then -17.93 end  +

		case bal_curr  when 'A' then -27.53 when 'B' then -13.55  when  'C'  then  9.50  when  'D' then 19.93  end  +

		case int_huoqi  when 'A' then -30.39 when 'B' then -5.71  when  'C'  then  20.06 when  'D' then 	6.57  end  +

		case cnt_salmonth  when 'A' then -39.71 when 'B' then -39.71  when  'C'  then -20.57 when  'D' then 	5.40  end  +

		case out_amt_lc  when 'A' then -67.71  when 'B' then -67.71   when  'C'  then  -67.71  when  'D' then 3.06  end) as sc    from  t_summary) t order by t.sc  desc;



	#select  * from sxj  into outfile 'D:\\mysql-5.7.26-winx64\\data\\sxj.txt' lines TERMINATED by '\r\n';



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_outfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `p_outfile`()
BEGIN

	select  * from user_info  into outfile 'D:\\mysql-5.7.26-winx64\\data\\user_info.txt' lines TERMINATED by '\r\n';

	select  * from acc_info  into outfile 'D:\\mysql-5.7.26-winx64\\data\\acc_info.txt' lines TERMINATED by '\r\n';

	select  * from tran_info  into outfile 'D:\\mysql-5.7.26-winx64\\data\\tran_info.txt' lines TERMINATED by '\r\n';

	select  * from bal_info  into outfile 'D:\\mysql-5.7.26-winx64\\data\\bal_info.txt' lines TERMINATED by '\r\n';



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-27 17:51:18
