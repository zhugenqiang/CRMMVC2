----------------------------------------------------------------------
/*------------------------ 客户关系管理系统 ------------------------*/
----------------------------------------------------------------------

/*------------------------ 建库[lf_crm_db] -------------------------*/
--1.判断数据库是否已存在，是则删除--
use master 
go
if exists(select * from sysdatabases where name='lf_crm_db2')
drop database lf_crm_db2
go

--2.建立数据库--
create database lf_crm_db2
go
use lf_crm_db2
go

/*------------------------------ 建表 ------------------------------*/
--1.角色表(sys_role)--
create table sys_role
(
	role_id   int primary key identity(1,1) not null, --ID [主键，自动增长列]
	role_name varchar(50) unique               not null, --名称 [唯一约束]
	role_desc varchar(1000)                        null, --信息
	role_flag int                              not null  --状态 [0-正常，1-不正常]
)
go

--2.权限表(sys_right)--
create table sys_right
(
	right_code        varchar(50) primary key  not null, --节点代码 [主键列]
	right_parent_code varchar(50)                  null, --父节点
	right_type        varchar(50)                  null, --权限类型
	right_text        varchar(50)                  null, --权限描述
	right_url         varchar(100)                 null, --链接
	right_tip         varchar(50)                  null  --提示  
)
go

--3.用户表(sys_user)--
create table sys_user
(
	usr_id       int primary key identity(1,1) not null, --ID [主键，自动增长列]
	usr_name     varchar(20)                      not null, --名称
	usr_pwd      varchar(16)                      not null, --密码
	usr_role_id  int                           not null, --角色编号
	usr_state    int                              not null  --状态 [0正常，1不正常]
)
go

--4.角色权限关系表(sys_role_right)--
create table sys_role_right
(
	rf_id         int primary key identity(1,1) not null, --ID [主键，自动增长列]
	rf_role_id    int                           not null, --角色编号
	rf_right_code varchar(50)                      not null  --节点代码
)
go

--5.数据字典表(bas_dict)--
create table bas_dict
(
	dict_id          int primary key identity(1,1) not null, --ID [主键，自动增长列]
	dict_type        varchar(50)                      not null, --类别
	dict_item        varchar(50)                      not null, --条目
	dict_value       varchar(50)                      not null, --值
	dict_is_editable int                              not null  --是否可编辑[0/false:表示不可编辑，1/true:表示可编辑]
)
go

--6.销售机会信息表(sal_chance)--
create table sal_chance
(
	chc_id          int primary key identity(1,1) not null, --ID [主键，自动增长列]
	chc_source      varchar(50)                          null, --机会来源
	chc_cust_name   varchar(100)                     not null, --客户名称
	chc_title       varchar(200)                     not null, --慨要
	chc_rate        int                              not null, --成功几率
	chc_linkman     varchar(50)                          null, --联系人
	chc_tel         varchar(50)                          null, --联系人电话号码
	chc_desc        varchar(2000)                    not null, --机会描述
	chc_create_id   int                           not null, --创建人编号
	chc_create_by   varchar(50)                      not null, --创建人名称
	chc_create_date datetime default(getdate())      null, --创建时间 [默认为当前时间]
	chc_due_id      int default(0)                    null, --指派给编号
	chc_due_to      varchar(50)                          null, --被指派人
	chc_due_date    datetime default(getdate())          null, --指派时间 [默认为当前时间]
	chc_status      int default(0)                not null  --状态 [0-未指派 ，1-已指派/开发中，2-开发成功 ，3-开发失败，默认为0]
)
go

--7.客户开发计划表(sal_plan)--
create table sal_plan
(
	pla_id     int primary key identity(1,1) not null, --ID [主键，自动增长列]
	pla_chc_id int                           not null, --销售机会编号
	pla_date   datetime                         not null, --日期
	pla_todo   varchar(500)                     not null, --计划项
	pla_result varchar(500)                         null  --执行结果 [开发成功/开发失败]
)
go

--8.客户信息表(cst_customer)--
create table cst_customer
(
	cust_Id              int identity(1,1)    not null, --ID [自动增长列]
	cust_no              varchar(20) primary key not null, --客户编号 [主键列]
	cust_name            varchar(100)            not null, --客户名称
	cust_region          varchar(50)                 null, --客户地区
	cust_manager_id      int default(0)           null, --该客户对应的客户经理编号 [默认为：0]
	cust_manager_name    varchar(50)                 null, --该客户对应的客户经理名字
	cust_level           int default(1)              null, --客户等级 1-2-3-4-5 [默认为：1]
	cust_level_label     varchar(50)                 null, --客户等级 [1-普通客户，2-重点开发客户，3-大客户，4-合作伙伴，5-战略合作伙伴]
	cust_satisfy         int default(3)              null, --客户满意度 [默认为：3]
	cust_credit          int default(3)              null, --客户信用度 [默认为：3]
	cust_addr            varchar(200)                null, --客户地址
	cust_zip             varchar(10)                 null, --客户邮政编码
	cust_tel             varchar(50)                 null, --客户电话
	cust_fax             varchar(50)                 null, --客户传真
	cust_website         varchar(50)                 null, --客户网址
	cust_licence_no      varchar(50)                 null, --营业执照注册号
	cust_chieftain       varchar(50)                 null, --法人
	cust_bankroll        int default(0)           null, --注册资金 [默认为：0]
	cust_turnover        int default(0)           null, --营业额 [默认为：0]
	cust_bank            varchar(200)                null, --开户银行
	cust_bank_account    varchar(50)                 null, --银行帐号
	cust_local_tax_no    varchar(50)                 null, --地税登记号 
	cust_national_tax_no varchar(50)                 null, --国税登记号
	cust_status          varchar(10) default('1')    null  --状态 [0-正常，1-流失，2-删除] [默认为：'0']
)
go

--9.客户服务表(cst_service)--
create table cst_service
(
	svr_id          int primary key identity(1,1) not null, --ID [主键，自动增长列]
	svr_type        varchar(20)                      not null, --服务类型
	svr_title       varchar(500)                     not null, --概要
	svr_cust_no     varchar(20)                      not null, --客户编号
	svr_cust_name   varchar(100)                     not null, --客户名称
	svr_status      varchar(10) default('新创建')    not null, --状态 [默认为：'新创建']
	svr_request     varchar(3000)                    not null, --服务请求
	svr_create_id   int                           not null, --创建人编号
	svr_create_by   varchar(50)                      not null, --创建人
	svr_create_date datetime default(getdate())      not null, --创建时间 [默认为当前时间]
	svr_due_id      int                               null, --分配给
	svr_due_to      varchar(50)                          null, --分配给
	svr_due_date    datetime                             null, --分配时间
	svr_deal        varchar(3000)                        null, --服务处理
	svr_deal_id     int                               null, --处理人编号
	svr_deal_by     varchar(50)                          null, --处理人名称
	svr_deal_date   datetime                             null, --处理时间
	svr_result      varchar(500)                         null, --处理结果
	svr_satisfy     int                                  null  --满意度
)
go

--10.交往记录表(cst_activity)--
create table cst_activity
(
	atv_id        int primary key identity(1,1) not null, --ID [主键，自动增长列]
	atv_cust_no   varchar(20)                      not null, --客户编号
	atv_cust_name varchar(100)                         null, --客户名称
	atv_date      datetime default(getdate())      not null, --时间
	atv_place     varchar(200)                     not null, --地点
	atv_title     varchar(500)                     not null, --概要 
	atv_desc      varchar(2000)                        null, --详细信息
	aty_remark    varchar(200)                         null  --备注
)
go

--11.客户流失管理表(cst_lost)--
create table cst_lost
(
	lst_id                int primary key identity(1,1) not null, --ID [主键，自动增长列]
	lst_cust_no           varchar(20)                      not null, --客户编号
	lst_cust_name         varchar(100)                         null, --客户名称
	lst_cust_manager_id   int                           not null, --客户经理编号
	lst_cust_manager_name varchar(50)                      not null, --客户经理名称
	lst_last_order_date   datetime                             null, --上次下单时间
	lst_lost_date         datetime                             null, --确认流失时间
	lst_delay             varchar(4000)                        null, --暂缓措施
	lst_reason            varchar(2000)                        null, --流失原因
	lst_status            int default(1)                   null  --状态 [1-预警，2-暂缓流失，3-已经流失] [默认为：1]
)
go

--12.客户联系人表(cst_linkman)--
create table cst_linkman
(
	lkm_id        int primary key identity(1,1) not null, --ID [主键，自动增长列]
	lkm_cust_no   varchar(20)                      not null, --客户编号
	lkm_cust_name varchar(100)                         null, --客户名称
	lkm_name      varchar(50)                      not null, --姓名
	lkm_sex       varchar(5) default('男')             null, --性别 [默认为：'男']
	lkm_postion   varchar(50)                          null, --职位
	lkm_tel       varchar(50)                          null, --办公电话
	lkm_mobile    varchar(50)                          null, --手机
	lkm_memo      varchar(300)                         null  --备注
)
go

--13.产品信息表(product)--
create table product
(
	prod_id    int primary key identity(1,1) not null, --ID [主键，自动增长列]
	prod_name  varchar(200)                     not null, --名称
	prod_type  varchar(100)                     not null, --型号
	prod_batch varchar(100)                         null, --批次/等级
	prod_unit  varchar(10)                          null, --单位
	prod_price money                                null, --单价
	prod_memo  varchar(200)                         null  --备注
)
go

--14.历史订单信息表(orders)--
create table orders
(
	odr_id         int primary key identity(1,1)                  not null, --ID [主键，自动增长列]
	odr_cust_no    varchar(20)                                       not null, --客户编号
	odr_cust_name  varchar(100)                                          null, --客户名称
	odr_date       datetime default(getdate())                       not null, --日期
	odr_addr       varchar(200)                                      not null, --送货地址
	odr_status     int default(1) check(odr_status in(0,1))          not null  --状态  [0-未回款；1-已回款] [Chek约束(只能是0，1)] [默认：1]
)
go

--15.订单信息表(orders_line)--
create table orders_line
(
	odd_id         int primary key identity(1,1) not null, --ID [主键，自动增长列]
	odd_order_id   int                           not null, --订单编号
	odd_prod_id    int                           not null, --产品编号
	odd_count      int default(0)                   not null, --数量 [默认为：0]
	odd_unit       varchar(10)                          null, --单位
	odd_price      money                                null  --总价             
)
go

--16.货物存储信息表(storage)--
create table storage
(
	stk_id        int primary key identity(1,1) not null, --ID [主键，自动增长列]
	stk_prod_id   int                           not null, --产品编号
	stk_warehouse varchar(50)                      not null, --仓库
	stk_ware      varchar(50)                      not null, --仓位
	stk_count     int                              not null, --件数
	stk_memo      varchar(200)                         null  --备注
)
go

/*--------------------------- 主外键约束 ---------------------------*/
--1.用户表(sys_user)--
alter table sys_user
      add constraint FK_usr_role_id foreign key(usr_role_id) references sys_role(role_id) --外键约束 [主键：sys_role(role_id)]

--2.角色权限关系表(sys_role_right)--
alter table sys_role_right
      add constraint FK_rf_role_id foreign key(rf_role_id) references sys_role(role_id) --外键约束 [主键：sys_role(role_id)]
alter table sys_role_right
      add constraint FK_rf_right_code foreign key(rf_right_code) references sys_right(right_code) --外键约束 [主键：sys_right(right_code)]

--3.客户开发计划表(sal_plan)--
alter table sal_plan
      add constraint FK_pla_chc_id foreign key(pla_chc_id) references sal_chance(chc_id) --外键约束 [主键：sal_chance(chc_id)]

--4.客户服务表(cst_service)--
alter table cst_service
      add constraint FK_svr_cust_no foreign key(svr_cust_no) references cst_customer(cust_no) on delete cascade --外键约束  [主键：cst_customer(cust_no)]

--5.交往记录表(cst_activity)--
alter table cst_activity
      add constraint FK_atv_cust_no foreign key(atv_cust_no) references cst_customer(cust_no) on delete cascade --外键约束  [主键：cst_customer(cust_no)]

--6.客户流失管理表(cst_lost)--
alter table cst_lost
      add constraint FK_lst_cust_no foreign key(lst_cust_no) references cst_customer(cust_no) on delete cascade --外键约束  [主键：cst_customer(cust_no)]

--7.客户联系人表(cst_linkman)--
alter table cst_linkman
      add constraint FK_lkm_cust_no foreign key(lkm_cust_no) references cst_customer(cust_no) on delete cascade --外键约束  [主键：cst_customer(cust_no)]

--8.订单信息表(orders_line)--
alter table orders_line
      add constraint FK_odd_order_id foreign key(odd_order_id) references orders(odr_id) on delete cascade --外键约束  [主键：orders(odr_id)]
alter table orders_line
      add constraint FK_odd_prod_id foreign key(odd_prod_id) references product(prod_id) --外键约束  [主键：product(prod_id)]

--9.货物存储信息表(storage)--
alter table storage
      add constraint FK_stk_prod_id foreign key(stk_prod_id) references product(prod_id) --外键约束  [主键：product(prod_id)]

--14.历史订单信息表(orders)--
alter table orders
      add constraint FK_odr_cust_no foreign key(odr_cust_no) references cst_customer(cust_no) on delete cascade --外键约束  [主键：cst_customer(cust_no)]

go

/*-------------------------- 插入测试数据 --------------------------*/
--1.角色表(sys_role)--
insert into sys_role values('系统管理员','管理系统用户、角色与权限，保证系统正常运行',0)
insert into sys_role values('销售主管','对客户服务进行分配。',0)
insert into sys_role values('客户经理','维护负责的客户信息。',0)
insert into sys_role values('高管','部分权限',0)

--2.权限表(sys_right)--
insert into sys_right values('001','000','','客户关系管理系统','','')
insert into sys_right values('002','001','','营销管理','','')
insert into sys_right values('003','001','','客户管理','','')
insert into sys_right values('004','001','','服务管理','','')
insert into sys_right values('005','001','','统计报表','','')
insert into sys_right values('006','001','','基础数据','','')
insert into sys_right values('007','001','','权限管理','','')

insert into sys_right values('008','002','','销售机会管理','/SalesLeads/Index','')
insert into sys_right values('009','002','','客户开发计划','/SalesPlan/Index','')

insert into sys_right values('010','003','','客户信息管理','/CustomerManager/Index','')
insert into sys_right values('011','003','','客户流失管理','/CustomerLost/Index','')

insert into sys_right values('012','004','','服务创建','/CustomerServiceManager/ServiceCreation','')
insert into sys_right values('013','004','','服务分配','/CustomerServiceManager/ServiceAdmeasure','')
insert into sys_right values('014','004','','服务处理','/CustomerServiceManager/ServiceDispose','')
insert into sys_right values('015','004','','服务反馈','/CustomerServiceManager/ServiceFeedback','')
insert into sys_right values('016','004','','服务归档','/CustomerServiceManager/ServicePigeonhole','')

insert into sys_right values('017','005','','客户贡献分析','/TheReports/Contribute','')
insert into sys_right values('018','005','','客户构成分析','/TheReports/Composing','')
insert into sys_right values('019','005','','客户服务分析','/TheReports/Service','')
insert into sys_right values('020','005','','客户流失分析','/TheReports/Lost','')

insert into sys_right values('021','006','','数据词典管理','/DataDictManager/Index','')
insert into sys_right values('022','006','','查询产品数据','/ProductSearch/Index','')
insert into sys_right values('023','006','','查询库存','/StorageSearch/Index','')

insert into sys_right values('024','007','','权限分配','/RightManager/Index','')

--3.用户表(sys_user)--
insert into sys_user values('admin','123456',1,0)
insert into sys_user values('xiaofei','123456',2,0)
insert into sys_user values('xiaobao','123456',3,0)
insert into sys_user values('xiaorui','123456',3,0)
insert into sys_user values('baobao','123456',3,0)
insert into sys_user values('baoqi','123456',3,0)
insert into sys_user values('tl','123456',4,0)
insert into sys_user values('feifei','123456',3,0)

--4.角色权限关系表(sys_role_right)--
insert into sys_role_right values(1,'001')
insert into sys_role_right values(1,'006')
insert into sys_role_right values(1,'021')
insert into sys_role_right values(1,'007')
insert into sys_role_right values(1,'024')

insert into sys_role_right values(2,'001')
insert into sys_role_right values(2,'002')
insert into sys_role_right values(2,'004')
insert into sys_role_right values(2,'005')
insert into sys_role_right values(2,'008')
insert into sys_role_right values(2,'009')
insert into sys_role_right values(2,'013')
insert into sys_role_right values(2,'016')
insert into sys_role_right values(2,'017')
insert into sys_role_right values(2,'018')
insert into sys_role_right values(2,'019')
insert into sys_role_right values(2,'020')

insert into sys_role_right values(3,'001')
insert into sys_role_right values(3,'002')
insert into sys_role_right values(3,'003')
insert into sys_role_right values(3,'004')
insert into sys_role_right values(3,'006')
insert into sys_role_right values(3,'008')
insert into sys_role_right values(3,'009')
insert into sys_role_right values(3,'010')
insert into sys_role_right values(3,'011')
insert into sys_role_right values(3,'012')
insert into sys_role_right values(3,'014')
insert into sys_role_right values(3,'015')
insert into sys_role_right values(3,'016')
insert into sys_role_right values(3,'022')
insert into sys_role_right values(3,'023')

insert into sys_role_right values(4,'001')
insert into sys_role_right values(4,'005')
insert into sys_role_right values(4,'017')
insert into sys_role_right values(4,'018')
insert into sys_role_right values(4,'019')
insert into sys_role_right values(4,'020')
--5.数据字典表(bas_dict)--
insert into bas_dict values('服务类型','咨询','咨询',1)
insert into bas_dict values('服务类型','建议','建议',1)
insert into bas_dict values('服务类型','投诉','投诉',1)
insert into bas_dict values('地区','河北','河北',1)
insert into bas_dict values('地区','北京','北京',1)
insert into bas_dict values('地区','东北','东北',1)
insert into bas_dict values('地区','中南','中南',1)
insert into bas_dict values('地区','上海','上海',1)
insert into bas_dict values('客户等级','普通客户','1',0)
insert into bas_dict values('客户等级','重点开发客户','2',0)
insert into bas_dict values('客户等级','大客户','3',0)
insert into bas_dict values('客户等级','合作伙伴','4',0)
insert into bas_dict values('客户等级','战略合作伙伴','5',0)
insert into bas_dict values('客户信用度','☆','1',0)
insert into bas_dict values('客户信用度','☆☆','2',0)
insert into bas_dict values('客户信用度','☆☆☆','3',0)
insert into bas_dict values('客户信用度','☆☆☆☆','4',0)
insert into bas_dict values('客户信用度','☆☆☆☆☆','5',0)
insert into bas_dict values('客户满意度','☆','1',0)
insert into bas_dict values('客户满意度','☆☆','2',0)
insert into bas_dict values('客户满意度','☆☆☆','3',0)
insert into bas_dict values('客户满意度','☆☆☆☆','4',0)
insert into bas_dict values('客户满意度','☆☆☆☆☆','5',0)
insert into bas_dict values('客户流失状态','预警','1',0)
insert into bas_dict values('客户流失状态','暂缓流失','2',0)
insert into bas_dict values('客户流失状态','已经流失','3',0)

--6.销售机会信息表(sal_chance)--
insert into sal_chance values('来源','客户','概要',80,'XXX','13729365245','暂无描述',4,'xiaorui','2007-12-5 12:22:35',null,null,null,0)
insert into sal_chance values('来源','名称','概要',90,'YYY','13721234239','机会描述',8,'feifei','2007-12-6 09:45:22',null,null,null,0)
insert into sal_chance values('来源','名称','概要',70,'ZZZ','13822221217','机会描述',3,'xiaobao','2007-12-6 05:52:10',null,null,null,0)
insert into sal_chance values('aaa','名称1','概要1',85,'dddd','13254239239','机会描述1',3,'xiaobao','2007-12-6 05:52:10',8,'feifei','2009-12-07',1)
insert into sal_chance values('bbb','名称2','概要2',87,'Zasda','13839253239','机会描述2',3,'xiaobao','2007-12-6 05:52:10',8,'feifei','2009-12-25',1)

--8.客户信息表(cst_customer)--
insert into cst_customer values('KH20090311','重庆无限科技有限公司','中南',8,'feifei',4,'合作伙伴',3,3,'重庆市渝中区','401333','023-12345678','023-12345678','www.cqlimited.com','No.20090311','三毛',1000,1000,'中国农业银行','95599 9999 99999 77777','L_no.20090311','N_no.20090311','1')
insert into cst_customer values('KH20090312','重庆天籁电器有限公司','东北',8,'feifei',5,'战略合作伙伴',4,4,'重庆足下','401222','023-62345678','023-62345678','www.cqnolimited.com','No.20090312','五娃',1000,1000,'中国农业银行','95599 9999 99999 88888','L_no.20090312','N_no.20090312','1')
insert into cst_customer values('KH20090313','四川无限有限公司','东北',6,'baoqi',4,'合作伙伴',2,1,'四川成都','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','四娃',1000,1000,'中国农业银行','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090314','中国上市公司','中南',6,'baoqi',3,'大客户',2,1,'四川成都','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','四娃',1000,1000,'中国农业银行','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090315','中国国际航空股份有限公司','北京',6,'baoqi',1,'普通客户',2,1,'四川成都','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','四娃',1000,1000,'中国农业银行','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090316','联想集团有限公司','东北',6,'baoqi',2,'重点开发客户',2,1,'四川成都','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','四娃',1000,1000,'中国农业银行','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')

--9.客户服务表(cst_service)--
insert into cst_service values('咨询','aaaa','KH20090311','重庆无限科技有限公司','已分配','aaaa',8,'feifei','2010-1-10 15:35:33',8,'feifei','2010-1-10 15:37:33',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('建议','bbbb','KH20090311','重庆无限科技有限公司','已分配','bbbb',8,'feifei','2010-1-10 15:35:44',8,'feifei','2010-1-10 15:37:20',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('建议','cccc','KH20090312','重庆天籁电器有限公司','新创建','cccc',8,'feifei','2010-1-10 15:36:02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('咨询','dddd','KH20090312','重庆天籁电器有限公司','新创建','dddd',8,'feifei','2010-1-10 15:36:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('投诉','ffff','KH20090313','四川无限有限公司','已分配','ffff',8,'feifei','2010-1-10 15:36:27',8,'feifei','2010-1-10 15:37:25',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('咨询','ssss','KH20090313','四川无限有限公司','新创建','ssss',8,'feifei','2010-1-10 15:36:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

--10.交往记录表(cst_activity)--
insert into cst_activity values('KH20090311','重庆无限科技有限公司','2009-03-03','公司','邀请到公司参观','...','...')
insert into cst_activity values('KH20090312','重庆天籁电器有限公司','2009-03-10','公司','邀请到公司参观','...','...')
insert into cst_activity values('KH20090313','四川无限有限公司','2009-03-15','公司','邀请到公司参观','...','...')

--11.客户流失管理表(cst_lost)--
insert into cst_lost values('KH20090311','重庆无限科技有限公司',8,'feifei','2008-12-07',null,null,null,1)
insert into cst_lost values('KH20090312','重庆天籁电器有限公司',8,'feifei','2007-09-23',null,'爱仕达<br />都是<br />都是<br />玩玩',null,2)
insert into cst_lost values('KH20090313','四川无限有限公司',6,'baoqi','2008-08-09','2009-02-22','打电话给客户了解不再购买本公司产品的原因。<br />发送新产品目录给客户。','诉讼',3)

--12.客户联系人表(cst_linkman)--
insert into cst_linkman values('KH20090311','重庆无限科技有限公司','张三','男','总经理','023-22345678','13512345678','暂无')
insert into cst_linkman values('KH20090311','重庆无限科技有限公司','小张','女','总经理助理','023-11354678','13454445676','暂无')
insert into cst_linkman values('KH20090311','重庆无限科技有限公司','小刘','男','总经理助理','010-68348438','13452335236','暂无')
insert into cst_linkman values('KH20090312','重庆天籁电器有限公司','李四','女','供销部经理','023-12345678','13912345678','暂无')
insert into cst_linkman values('KH20090312','重庆天籁电器有限公司','小李子','男','总经理','023-12345678','13245128875','暂无')
insert into cst_linkman values('KH20090312','重庆天籁电器有限公司','莉莉','女','经理','023-12455478','15845128875','暂无')
insert into cst_linkman values('KH20090313','四川无限有限公司','王五','男','总经理','028-12345678','13512345678','暂无')
insert into cst_linkman values('KH20090313','四川无限有限公司','妮妮','女','供销部经理','024-12415426','13883345678','暂无')
insert into cst_linkman values('KH20090313','四川无限有限公司','哔哔','女','总经理','021-12345678','13512345678','暂无')

--13.产品信息表(product)--
insert into product values('幸福牌电视机','818 FFT','2388 EA03','台',7500,'代生产')
insert into product values('幸福牌收音机','天语007','7878 006A','台',3600,'代生产')
insert into product values('海龙笔记本电脑','i60','2688 9966','台',9800,'暂无')
insert into product values('海龙笔记本电脑','i61','2689 6688','台',16800,'暂无')
insert into product values('海龙笔记本电脑','i61','2689 6689','台',15800,'暂无')


--14.历史订单信息表(orders)--
insert into orders values('KH20090311','重庆无限科技有限公司','2009-9-11','重庆沙坪坝',1)
insert into orders values('KH20090311','重庆无限科技有限公司','2009-10-5','重庆沙坪坝',0)
insert into orders values('KH20090312','重庆天籁电器有限公司','2008-10-21','重庆沙坪坝',1)
insert into orders values('KH20090312','重庆天籁电器有限公司','2009-12-15','重庆渝中区',1)
insert into orders values('KH20090313','四川无限有限公司','2008-2-2','重庆巴南区',1)
insert into orders values('KH20090313','四川无限有限公司','2009-1-1','重庆渝中区',0)
insert into orders values('KH20090313','四川无限有限公司','2009-12-18','重庆渝中区',0)

--15.订单信息表(orders_line)--
insert into orders_line values(1,3,5,'台',29400)
insert into orders_line values(1,5,2,'台',79000)
insert into orders_line values(2,1,2,'台',7500)
insert into orders_line values(3,4,10,'台',67200)
insert into orders_line values(4,3,15,'台',29400)
insert into orders_line values(5,2,5,'台',7200)
insert into orders_line values(6,2,5,'台',7200)
insert into orders_line values(7,3,5,'台',29400)

--16.货物存储信息表(storage)--
insert into storage values(1,'北京-西直门库','EC-D2',16,'暂无')
insert into storage values(4,'北京-大钟寺库','EA-B8',12,'暂无')
insert into storage values(4,'北京-马甸库',	'EA-A6',8,'暂无')
insert into storage values(2,'天津-恒远电子C库','北26位',36,'暂无')
insert into storage values(2,'天津-恒远电子C库','北27位',36,'暂无')
insert into storage values(3,'重庆-电子A库','北28位',35,'暂无')
insert into storage values(3,'重庆-电子A库','北28位',28,'暂无')
insert into storage values(5,'重庆-电子D库','北28位',15,'暂无')
insert into storage values(5,'重庆-电子D库','北28位',10,'暂无')


/*-------------------------- 查询记录 --------------------------*/
/*
    select * from sys_role       --角色表
    select * from sys_right      --权限表
    select * from sys_user       --用户表
    select * from sys_role_right --角色权限关系表
    select * from bas_dict       --数据字典表
    select * from sal_chance     --销售机会表
    select * from sal_plan       --客户开发计划表
    select * from cst_customer   --客户信息表
    select * from cst_service    --客户服务表
    select * from cst_activity   --交往记录表
    select * from cst_lost       --客户流失管理表
    select * from cst_linkman    --客户联系人表
    select * from product        --产品信息表
    select * from orders         --历史订单信息表
    select * from orders_line    --订单信息表
    select * from storage        --货物存储信息表
*/