using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CRM.Model;

namespace CRM.DAL
{
    /// <summary>
    /// 订单详细数据访问类
    /// </summary>
   public class orders_lineRepository
   {
       private LinqHelper helper = new LinqHelper();
       /// <summary>
       /// 根据订单编号获得订单详细记录
       /// </summary>
       /// <param name="p"></param>
       /// <returns></returns>
        public List<orders_line> GetOrderLinesByOrderId(int p)
        {
            return helper.GetDataContext().orders_line.Where(l => l.odd_order_id == p).ToList();
        }
   }
}
