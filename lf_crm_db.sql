----------------------------------------------------------------------
/*------------------------ �ͻ���ϵ����ϵͳ ------------------------*/
----------------------------------------------------------------------

/*------------------------ ����[lf_crm_db] -------------------------*/
--1.�ж����ݿ��Ƿ��Ѵ��ڣ�����ɾ��--
use master 
go
if exists(select * from sysdatabases where name='lf_crm_db2')
drop database lf_crm_db2
go

--2.�������ݿ�--
create database lf_crm_db2
go
use lf_crm_db2
go

/*------------------------------ ���� ------------------------------*/
--1.��ɫ��(sys_role)--
create table sys_role
(
	role_id   int primary key identity(1,1) not null, --ID [�������Զ�������]
	role_name varchar(50) unique               not null, --���� [ΨһԼ��]
	role_desc varchar(1000)                        null, --��Ϣ
	role_flag int                              not null  --״̬ [0-������1-������]
)
go

--2.Ȩ�ޱ�(sys_right)--
create table sys_right
(
	right_code        varchar(50) primary key  not null, --�ڵ���� [������]
	right_parent_code varchar(50)                  null, --���ڵ�
	right_type        varchar(50)                  null, --Ȩ������
	right_text        varchar(50)                  null, --Ȩ������
	right_url         varchar(100)                 null, --����
	right_tip         varchar(50)                  null  --��ʾ  
)
go

--3.�û���(sys_user)--
create table sys_user
(
	usr_id       int primary key identity(1,1) not null, --ID [�������Զ�������]
	usr_name     varchar(20)                      not null, --����
	usr_pwd      varchar(16)                      not null, --����
	usr_role_id  int                           not null, --��ɫ���
	usr_state    int                              not null  --״̬ [0������1������]
)
go

--4.��ɫȨ�޹�ϵ��(sys_role_right)--
create table sys_role_right
(
	rf_id         int primary key identity(1,1) not null, --ID [�������Զ�������]
	rf_role_id    int                           not null, --��ɫ���
	rf_right_code varchar(50)                      not null  --�ڵ����
)
go

--5.�����ֵ��(bas_dict)--
create table bas_dict
(
	dict_id          int primary key identity(1,1) not null, --ID [�������Զ�������]
	dict_type        varchar(50)                      not null, --���
	dict_item        varchar(50)                      not null, --��Ŀ
	dict_value       varchar(50)                      not null, --ֵ
	dict_is_editable int                              not null  --�Ƿ�ɱ༭[0/false:��ʾ���ɱ༭��1/true:��ʾ�ɱ༭]
)
go

--6.���ۻ�����Ϣ��(sal_chance)--
create table sal_chance
(
	chc_id          int primary key identity(1,1) not null, --ID [�������Զ�������]
	chc_source      varchar(50)                          null, --������Դ
	chc_cust_name   varchar(100)                     not null, --�ͻ�����
	chc_title       varchar(200)                     not null, --��Ҫ
	chc_rate        int                              not null, --�ɹ�����
	chc_linkman     varchar(50)                          null, --��ϵ��
	chc_tel         varchar(50)                          null, --��ϵ�˵绰����
	chc_desc        varchar(2000)                    not null, --��������
	chc_create_id   int                           not null, --�����˱��
	chc_create_by   varchar(50)                      not null, --����������
	chc_create_date datetime default(getdate())      null, --����ʱ�� [Ĭ��Ϊ��ǰʱ��]
	chc_due_id      int default(0)                    null, --ָ�ɸ����
	chc_due_to      varchar(50)                          null, --��ָ����
	chc_due_date    datetime default(getdate())          null, --ָ��ʱ�� [Ĭ��Ϊ��ǰʱ��]
	chc_status      int default(0)                not null  --״̬ [0-δָ�� ��1-��ָ��/�����У�2-�����ɹ� ��3-����ʧ�ܣ�Ĭ��Ϊ0]
)
go

--7.�ͻ������ƻ���(sal_plan)--
create table sal_plan
(
	pla_id     int primary key identity(1,1) not null, --ID [�������Զ�������]
	pla_chc_id int                           not null, --���ۻ�����
	pla_date   datetime                         not null, --����
	pla_todo   varchar(500)                     not null, --�ƻ���
	pla_result varchar(500)                         null  --ִ�н�� [�����ɹ�/����ʧ��]
)
go

--8.�ͻ���Ϣ��(cst_customer)--
create table cst_customer
(
	cust_Id              int identity(1,1)    not null, --ID [�Զ�������]
	cust_no              varchar(20) primary key not null, --�ͻ���� [������]
	cust_name            varchar(100)            not null, --�ͻ�����
	cust_region          varchar(50)                 null, --�ͻ�����
	cust_manager_id      int default(0)           null, --�ÿͻ���Ӧ�Ŀͻ������� [Ĭ��Ϊ��0]
	cust_manager_name    varchar(50)                 null, --�ÿͻ���Ӧ�Ŀͻ���������
	cust_level           int default(1)              null, --�ͻ��ȼ� 1-2-3-4-5 [Ĭ��Ϊ��1]
	cust_level_label     varchar(50)                 null, --�ͻ��ȼ� [1-��ͨ�ͻ���2-�ص㿪���ͻ���3-��ͻ���4-������飬5-ս�Ժ������]
	cust_satisfy         int default(3)              null, --�ͻ������ [Ĭ��Ϊ��3]
	cust_credit          int default(3)              null, --�ͻ����ö� [Ĭ��Ϊ��3]
	cust_addr            varchar(200)                null, --�ͻ���ַ
	cust_zip             varchar(10)                 null, --�ͻ���������
	cust_tel             varchar(50)                 null, --�ͻ��绰
	cust_fax             varchar(50)                 null, --�ͻ�����
	cust_website         varchar(50)                 null, --�ͻ���ַ
	cust_licence_no      varchar(50)                 null, --Ӫҵִ��ע���
	cust_chieftain       varchar(50)                 null, --����
	cust_bankroll        int default(0)           null, --ע���ʽ� [Ĭ��Ϊ��0]
	cust_turnover        int default(0)           null, --Ӫҵ�� [Ĭ��Ϊ��0]
	cust_bank            varchar(200)                null, --��������
	cust_bank_account    varchar(50)                 null, --�����ʺ�
	cust_local_tax_no    varchar(50)                 null, --��˰�ǼǺ� 
	cust_national_tax_no varchar(50)                 null, --��˰�ǼǺ�
	cust_status          varchar(10) default('1')    null  --״̬ [0-������1-��ʧ��2-ɾ��] [Ĭ��Ϊ��'0']
)
go

--9.�ͻ������(cst_service)--
create table cst_service
(
	svr_id          int primary key identity(1,1) not null, --ID [�������Զ�������]
	svr_type        varchar(20)                      not null, --��������
	svr_title       varchar(500)                     not null, --��Ҫ
	svr_cust_no     varchar(20)                      not null, --�ͻ����
	svr_cust_name   varchar(100)                     not null, --�ͻ�����
	svr_status      varchar(10) default('�´���')    not null, --״̬ [Ĭ��Ϊ��'�´���']
	svr_request     varchar(3000)                    not null, --��������
	svr_create_id   int                           not null, --�����˱��
	svr_create_by   varchar(50)                      not null, --������
	svr_create_date datetime default(getdate())      not null, --����ʱ�� [Ĭ��Ϊ��ǰʱ��]
	svr_due_id      int                               null, --�����
	svr_due_to      varchar(50)                          null, --�����
	svr_due_date    datetime                             null, --����ʱ��
	svr_deal        varchar(3000)                        null, --������
	svr_deal_id     int                               null, --�����˱��
	svr_deal_by     varchar(50)                          null, --����������
	svr_deal_date   datetime                             null, --����ʱ��
	svr_result      varchar(500)                         null, --������
	svr_satisfy     int                                  null  --�����
)
go

--10.������¼��(cst_activity)--
create table cst_activity
(
	atv_id        int primary key identity(1,1) not null, --ID [�������Զ�������]
	atv_cust_no   varchar(20)                      not null, --�ͻ����
	atv_cust_name varchar(100)                         null, --�ͻ�����
	atv_date      datetime default(getdate())      not null, --ʱ��
	atv_place     varchar(200)                     not null, --�ص�
	atv_title     varchar(500)                     not null, --��Ҫ 
	atv_desc      varchar(2000)                        null, --��ϸ��Ϣ
	aty_remark    varchar(200)                         null  --��ע
)
go

--11.�ͻ���ʧ�����(cst_lost)--
create table cst_lost
(
	lst_id                int primary key identity(1,1) not null, --ID [�������Զ�������]
	lst_cust_no           varchar(20)                      not null, --�ͻ����
	lst_cust_name         varchar(100)                         null, --�ͻ�����
	lst_cust_manager_id   int                           not null, --�ͻ�������
	lst_cust_manager_name varchar(50)                      not null, --�ͻ���������
	lst_last_order_date   datetime                             null, --�ϴ��µ�ʱ��
	lst_lost_date         datetime                             null, --ȷ����ʧʱ��
	lst_delay             varchar(4000)                        null, --�ݻ���ʩ
	lst_reason            varchar(2000)                        null, --��ʧԭ��
	lst_status            int default(1)                   null  --״̬ [1-Ԥ����2-�ݻ���ʧ��3-�Ѿ���ʧ] [Ĭ��Ϊ��1]
)
go

--12.�ͻ���ϵ�˱�(cst_linkman)--
create table cst_linkman
(
	lkm_id        int primary key identity(1,1) not null, --ID [�������Զ�������]
	lkm_cust_no   varchar(20)                      not null, --�ͻ����
	lkm_cust_name varchar(100)                         null, --�ͻ�����
	lkm_name      varchar(50)                      not null, --����
	lkm_sex       varchar(5) default('��')             null, --�Ա� [Ĭ��Ϊ��'��']
	lkm_postion   varchar(50)                          null, --ְλ
	lkm_tel       varchar(50)                          null, --�칫�绰
	lkm_mobile    varchar(50)                          null, --�ֻ�
	lkm_memo      varchar(300)                         null  --��ע
)
go

--13.��Ʒ��Ϣ��(product)--
create table product
(
	prod_id    int primary key identity(1,1) not null, --ID [�������Զ�������]
	prod_name  varchar(200)                     not null, --����
	prod_type  varchar(100)                     not null, --�ͺ�
	prod_batch varchar(100)                         null, --����/�ȼ�
	prod_unit  varchar(10)                          null, --��λ
	prod_price money                                null, --����
	prod_memo  varchar(200)                         null  --��ע
)
go

--14.��ʷ������Ϣ��(orders)--
create table orders
(
	odr_id         int primary key identity(1,1)                  not null, --ID [�������Զ�������]
	odr_cust_no    varchar(20)                                       not null, --�ͻ����
	odr_cust_name  varchar(100)                                          null, --�ͻ�����
	odr_date       datetime default(getdate())                       not null, --����
	odr_addr       varchar(200)                                      not null, --�ͻ���ַ
	odr_status     int default(1) check(odr_status in(0,1))          not null  --״̬  [0-δ�ؿ1-�ѻؿ�] [ChekԼ��(ֻ����0��1)] [Ĭ�ϣ�1]
)
go

--15.������Ϣ��(orders_line)--
create table orders_line
(
	odd_id         int primary key identity(1,1) not null, --ID [�������Զ�������]
	odd_order_id   int                           not null, --�������
	odd_prod_id    int                           not null, --��Ʒ���
	odd_count      int default(0)                   not null, --���� [Ĭ��Ϊ��0]
	odd_unit       varchar(10)                          null, --��λ
	odd_price      money                                null  --�ܼ�             
)
go

--16.����洢��Ϣ��(storage)--
create table storage
(
	stk_id        int primary key identity(1,1) not null, --ID [�������Զ�������]
	stk_prod_id   int                           not null, --��Ʒ���
	stk_warehouse varchar(50)                      not null, --�ֿ�
	stk_ware      varchar(50)                      not null, --��λ
	stk_count     int                              not null, --����
	stk_memo      varchar(200)                         null  --��ע
)
go

/*--------------------------- �����Լ�� ---------------------------*/
--1.�û���(sys_user)--
alter table sys_user
      add constraint FK_usr_role_id foreign key(usr_role_id) references sys_role(role_id) --���Լ�� [������sys_role(role_id)]

--2.��ɫȨ�޹�ϵ��(sys_role_right)--
alter table sys_role_right
      add constraint FK_rf_role_id foreign key(rf_role_id) references sys_role(role_id) --���Լ�� [������sys_role(role_id)]
alter table sys_role_right
      add constraint FK_rf_right_code foreign key(rf_right_code) references sys_right(right_code) --���Լ�� [������sys_right(right_code)]

--3.�ͻ������ƻ���(sal_plan)--
alter table sal_plan
      add constraint FK_pla_chc_id foreign key(pla_chc_id) references sal_chance(chc_id) --���Լ�� [������sal_chance(chc_id)]

--4.�ͻ������(cst_service)--
alter table cst_service
      add constraint FK_svr_cust_no foreign key(svr_cust_no) references cst_customer(cust_no) on delete cascade --���Լ��  [������cst_customer(cust_no)]

--5.������¼��(cst_activity)--
alter table cst_activity
      add constraint FK_atv_cust_no foreign key(atv_cust_no) references cst_customer(cust_no) on delete cascade --���Լ��  [������cst_customer(cust_no)]

--6.�ͻ���ʧ�����(cst_lost)--
alter table cst_lost
      add constraint FK_lst_cust_no foreign key(lst_cust_no) references cst_customer(cust_no) on delete cascade --���Լ��  [������cst_customer(cust_no)]

--7.�ͻ���ϵ�˱�(cst_linkman)--
alter table cst_linkman
      add constraint FK_lkm_cust_no foreign key(lkm_cust_no) references cst_customer(cust_no) on delete cascade --���Լ��  [������cst_customer(cust_no)]

--8.������Ϣ��(orders_line)--
alter table orders_line
      add constraint FK_odd_order_id foreign key(odd_order_id) references orders(odr_id) on delete cascade --���Լ��  [������orders(odr_id)]
alter table orders_line
      add constraint FK_odd_prod_id foreign key(odd_prod_id) references product(prod_id) --���Լ��  [������product(prod_id)]

--9.����洢��Ϣ��(storage)--
alter table storage
      add constraint FK_stk_prod_id foreign key(stk_prod_id) references product(prod_id) --���Լ��  [������product(prod_id)]

--14.��ʷ������Ϣ��(orders)--
alter table orders
      add constraint FK_odr_cust_no foreign key(odr_cust_no) references cst_customer(cust_no) on delete cascade --���Լ��  [������cst_customer(cust_no)]

go

/*-------------------------- ����������� --------------------------*/
--1.��ɫ��(sys_role)--
insert into sys_role values('ϵͳ����Ա','����ϵͳ�û�����ɫ��Ȩ�ޣ���֤ϵͳ��������',0)
insert into sys_role values('��������','�Կͻ�������з��䡣',0)
insert into sys_role values('�ͻ�����','ά������Ŀͻ���Ϣ��',0)
insert into sys_role values('�߹�','����Ȩ��',0)

--2.Ȩ�ޱ�(sys_right)--
insert into sys_right values('001','000','','�ͻ���ϵ����ϵͳ','','')
insert into sys_right values('002','001','','Ӫ������','','')
insert into sys_right values('003','001','','�ͻ�����','','')
insert into sys_right values('004','001','','�������','','')
insert into sys_right values('005','001','','ͳ�Ʊ���','','')
insert into sys_right values('006','001','','��������','','')
insert into sys_right values('007','001','','Ȩ�޹���','','')

insert into sys_right values('008','002','','���ۻ������','/SalesLeads/Index','')
insert into sys_right values('009','002','','�ͻ������ƻ�','/SalesPlan/Index','')

insert into sys_right values('010','003','','�ͻ���Ϣ����','/CustomerManager/Index','')
insert into sys_right values('011','003','','�ͻ���ʧ����','/CustomerLost/Index','')

insert into sys_right values('012','004','','���񴴽�','/CustomerServiceManager/ServiceCreation','')
insert into sys_right values('013','004','','�������','/CustomerServiceManager/ServiceAdmeasure','')
insert into sys_right values('014','004','','������','/CustomerServiceManager/ServiceDispose','')
insert into sys_right values('015','004','','������','/CustomerServiceManager/ServiceFeedback','')
insert into sys_right values('016','004','','����鵵','/CustomerServiceManager/ServicePigeonhole','')

insert into sys_right values('017','005','','�ͻ����׷���','/TheReports/Contribute','')
insert into sys_right values('018','005','','�ͻ����ɷ���','/TheReports/Composing','')
insert into sys_right values('019','005','','�ͻ��������','/TheReports/Service','')
insert into sys_right values('020','005','','�ͻ���ʧ����','/TheReports/Lost','')

insert into sys_right values('021','006','','���ݴʵ����','/DataDictManager/Index','')
insert into sys_right values('022','006','','��ѯ��Ʒ����','/ProductSearch/Index','')
insert into sys_right values('023','006','','��ѯ���','/StorageSearch/Index','')

insert into sys_right values('024','007','','Ȩ�޷���','/RightManager/Index','')

--3.�û���(sys_user)--
insert into sys_user values('admin','123456',1,0)
insert into sys_user values('xiaofei','123456',2,0)
insert into sys_user values('xiaobao','123456',3,0)
insert into sys_user values('xiaorui','123456',3,0)
insert into sys_user values('baobao','123456',3,0)
insert into sys_user values('baoqi','123456',3,0)
insert into sys_user values('tl','123456',4,0)
insert into sys_user values('feifei','123456',3,0)

--4.��ɫȨ�޹�ϵ��(sys_role_right)--
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
--5.�����ֵ��(bas_dict)--
insert into bas_dict values('��������','��ѯ','��ѯ',1)
insert into bas_dict values('��������','����','����',1)
insert into bas_dict values('��������','Ͷ��','Ͷ��',1)
insert into bas_dict values('����','�ӱ�','�ӱ�',1)
insert into bas_dict values('����','����','����',1)
insert into bas_dict values('����','����','����',1)
insert into bas_dict values('����','����','����',1)
insert into bas_dict values('����','�Ϻ�','�Ϻ�',1)
insert into bas_dict values('�ͻ��ȼ�','��ͨ�ͻ�','1',0)
insert into bas_dict values('�ͻ��ȼ�','�ص㿪���ͻ�','2',0)
insert into bas_dict values('�ͻ��ȼ�','��ͻ�','3',0)
insert into bas_dict values('�ͻ��ȼ�','�������','4',0)
insert into bas_dict values('�ͻ��ȼ�','ս�Ժ������','5',0)
insert into bas_dict values('�ͻ����ö�','��','1',0)
insert into bas_dict values('�ͻ����ö�','���','2',0)
insert into bas_dict values('�ͻ����ö�','����','3',0)
insert into bas_dict values('�ͻ����ö�','�����','4',0)
insert into bas_dict values('�ͻ����ö�','������','5',0)
insert into bas_dict values('�ͻ������','��','1',0)
insert into bas_dict values('�ͻ������','���','2',0)
insert into bas_dict values('�ͻ������','����','3',0)
insert into bas_dict values('�ͻ������','�����','4',0)
insert into bas_dict values('�ͻ������','������','5',0)
insert into bas_dict values('�ͻ���ʧ״̬','Ԥ��','1',0)
insert into bas_dict values('�ͻ���ʧ״̬','�ݻ���ʧ','2',0)
insert into bas_dict values('�ͻ���ʧ״̬','�Ѿ���ʧ','3',0)

--6.���ۻ�����Ϣ��(sal_chance)--
insert into sal_chance values('��Դ','�ͻ�','��Ҫ',80,'XXX','13729365245','��������',4,'xiaorui','2007-12-5 12:22:35',null,null,null,0)
insert into sal_chance values('��Դ','����','��Ҫ',90,'YYY','13721234239','��������',8,'feifei','2007-12-6 09:45:22',null,null,null,0)
insert into sal_chance values('��Դ','����','��Ҫ',70,'ZZZ','13822221217','��������',3,'xiaobao','2007-12-6 05:52:10',null,null,null,0)
insert into sal_chance values('aaa','����1','��Ҫ1',85,'dddd','13254239239','��������1',3,'xiaobao','2007-12-6 05:52:10',8,'feifei','2009-12-07',1)
insert into sal_chance values('bbb','����2','��Ҫ2',87,'Zasda','13839253239','��������2',3,'xiaobao','2007-12-6 05:52:10',8,'feifei','2009-12-25',1)

--8.�ͻ���Ϣ��(cst_customer)--
insert into cst_customer values('KH20090311','�������޿Ƽ����޹�˾','����',8,'feifei',4,'�������',3,3,'������������','401333','023-12345678','023-12345678','www.cqlimited.com','No.20090311','��ë',1000,1000,'�й�ũҵ����','95599 9999 99999 77777','L_no.20090311','N_no.20090311','1')
insert into cst_customer values('KH20090312','���������������޹�˾','����',8,'feifei',5,'ս�Ժ������',4,4,'��������','401222','023-62345678','023-62345678','www.cqnolimited.com','No.20090312','����',1000,1000,'�й�ũҵ����','95599 9999 99999 88888','L_no.20090312','N_no.20090312','1')
insert into cst_customer values('KH20090313','�Ĵ��������޹�˾','����',6,'baoqi',4,'�������',2,1,'�Ĵ��ɶ�','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','����',1000,1000,'�й�ũҵ����','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090314','�й����й�˾','����',6,'baoqi',3,'��ͻ�',2,1,'�Ĵ��ɶ�','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','����',1000,1000,'�й�ũҵ����','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090315','�й����ʺ��չɷ����޹�˾','����',6,'baoqi',1,'��ͨ�ͻ�',2,1,'�Ĵ��ɶ�','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','����',1000,1000,'�й�ũҵ����','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')
insert into cst_customer values('KH20090316','���뼯�����޹�˾','����',6,'baoqi',2,'�ص㿪���ͻ�',2,1,'�Ĵ��ɶ�','601223','028-12345678','028-12345678','www.sichuanNoLimited.com','No.20090313','����',1000,1000,'�й�ũҵ����','95599 8047 99999 99999','L_no.20090313','N_no.20090313','1')

--9.�ͻ������(cst_service)--
insert into cst_service values('��ѯ','aaaa','KH20090311','�������޿Ƽ����޹�˾','�ѷ���','aaaa',8,'feifei','2010-1-10 15:35:33',8,'feifei','2010-1-10 15:37:33',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('����','bbbb','KH20090311','�������޿Ƽ����޹�˾','�ѷ���','bbbb',8,'feifei','2010-1-10 15:35:44',8,'feifei','2010-1-10 15:37:20',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('����','cccc','KH20090312','���������������޹�˾','�´���','cccc',8,'feifei','2010-1-10 15:36:02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('��ѯ','dddd','KH20090312','���������������޹�˾','�´���','dddd',8,'feifei','2010-1-10 15:36:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('Ͷ��','ffff','KH20090313','�Ĵ��������޹�˾','�ѷ���','ffff',8,'feifei','2010-1-10 15:36:27',8,'feifei','2010-1-10 15:37:25',NULL,NULL,NULL,NULL,NULL,NULL)
insert into cst_service values('��ѯ','ssss','KH20090313','�Ĵ��������޹�˾','�´���','ssss',8,'feifei','2010-1-10 15:36:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

--10.������¼��(cst_activity)--
insert into cst_activity values('KH20090311','�������޿Ƽ����޹�˾','2009-03-03','��˾','���뵽��˾�ι�','...','...')
insert into cst_activity values('KH20090312','���������������޹�˾','2009-03-10','��˾','���뵽��˾�ι�','...','...')
insert into cst_activity values('KH20090313','�Ĵ��������޹�˾','2009-03-15','��˾','���뵽��˾�ι�','...','...')

--11.�ͻ���ʧ�����(cst_lost)--
insert into cst_lost values('KH20090311','�������޿Ƽ����޹�˾',8,'feifei','2008-12-07',null,null,null,1)
insert into cst_lost values('KH20090312','���������������޹�˾',8,'feifei','2007-09-23',null,'���˴�<br />����<br />����<br />����',null,2)
insert into cst_lost values('KH20090313','�Ĵ��������޹�˾',6,'baoqi','2008-08-09','2009-02-22','��绰���ͻ��˽ⲻ�ٹ��򱾹�˾��Ʒ��ԭ��<br />�����²�ƷĿ¼���ͻ���','����',3)

--12.�ͻ���ϵ�˱�(cst_linkman)--
insert into cst_linkman values('KH20090311','�������޿Ƽ����޹�˾','����','��','�ܾ���','023-22345678','13512345678','����')
insert into cst_linkman values('KH20090311','�������޿Ƽ����޹�˾','С��','Ů','�ܾ�������','023-11354678','13454445676','����')
insert into cst_linkman values('KH20090311','�������޿Ƽ����޹�˾','С��','��','�ܾ�������','010-68348438','13452335236','����')
insert into cst_linkman values('KH20090312','���������������޹�˾','����','Ů','����������','023-12345678','13912345678','����')
insert into cst_linkman values('KH20090312','���������������޹�˾','С����','��','�ܾ���','023-12345678','13245128875','����')
insert into cst_linkman values('KH20090312','���������������޹�˾','����','Ů','����','023-12455478','15845128875','����')
insert into cst_linkman values('KH20090313','�Ĵ��������޹�˾','����','��','�ܾ���','028-12345678','13512345678','����')
insert into cst_linkman values('KH20090313','�Ĵ��������޹�˾','����','Ů','����������','024-12415426','13883345678','����')
insert into cst_linkman values('KH20090313','�Ĵ��������޹�˾','����','Ů','�ܾ���','021-12345678','13512345678','����')

--13.��Ʒ��Ϣ��(product)--
insert into product values('�Ҹ��Ƶ��ӻ�','818 FFT','2388 EA03','̨',7500,'������')
insert into product values('�Ҹ���������','����007','7878 006A','̨',3600,'������')
insert into product values('�����ʼǱ�����','i60','2688 9966','̨',9800,'����')
insert into product values('�����ʼǱ�����','i61','2689 6688','̨',16800,'����')
insert into product values('�����ʼǱ�����','i61','2689 6689','̨',15800,'����')


--14.��ʷ������Ϣ��(orders)--
insert into orders values('KH20090311','�������޿Ƽ����޹�˾','2009-9-11','����ɳƺ��',1)
insert into orders values('KH20090311','�������޿Ƽ����޹�˾','2009-10-5','����ɳƺ��',0)
insert into orders values('KH20090312','���������������޹�˾','2008-10-21','����ɳƺ��',1)
insert into orders values('KH20090312','���������������޹�˾','2009-12-15','����������',1)
insert into orders values('KH20090313','�Ĵ��������޹�˾','2008-2-2','���������',1)
insert into orders values('KH20090313','�Ĵ��������޹�˾','2009-1-1','����������',0)
insert into orders values('KH20090313','�Ĵ��������޹�˾','2009-12-18','����������',0)

--15.������Ϣ��(orders_line)--
insert into orders_line values(1,3,5,'̨',29400)
insert into orders_line values(1,5,2,'̨',79000)
insert into orders_line values(2,1,2,'̨',7500)
insert into orders_line values(3,4,10,'̨',67200)
insert into orders_line values(4,3,15,'̨',29400)
insert into orders_line values(5,2,5,'̨',7200)
insert into orders_line values(6,2,5,'̨',7200)
insert into orders_line values(7,3,5,'̨',29400)

--16.����洢��Ϣ��(storage)--
insert into storage values(1,'����-��ֱ�ſ�','EC-D2',16,'����')
insert into storage values(4,'����-�����¿�','EA-B8',12,'����')
insert into storage values(4,'����-����',	'EA-A6',8,'����')
insert into storage values(2,'���-��Զ����C��','��26λ',36,'����')
insert into storage values(2,'���-��Զ����C��','��27λ',36,'����')
insert into storage values(3,'����-����A��','��28λ',35,'����')
insert into storage values(3,'����-����A��','��28λ',28,'����')
insert into storage values(5,'����-����D��','��28λ',15,'����')
insert into storage values(5,'����-����D��','��28λ',10,'����')


/*-------------------------- ��ѯ��¼ --------------------------*/
/*
    select * from sys_role       --��ɫ��
    select * from sys_right      --Ȩ�ޱ�
    select * from sys_user       --�û���
    select * from sys_role_right --��ɫȨ�޹�ϵ��
    select * from bas_dict       --�����ֵ��
    select * from sal_chance     --���ۻ����
    select * from sal_plan       --�ͻ������ƻ���
    select * from cst_customer   --�ͻ���Ϣ��
    select * from cst_service    --�ͻ������
    select * from cst_activity   --������¼��
    select * from cst_lost       --�ͻ���ʧ�����
    select * from cst_linkman    --�ͻ���ϵ�˱�
    select * from product        --��Ʒ��Ϣ��
    select * from orders         --��ʷ������Ϣ��
    select * from orders_line    --������Ϣ��
    select * from storage        --����洢��Ϣ��
*/