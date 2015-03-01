using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CRM.Model;
using CRM.BLL;

namespace CRM.Web.Controllers
{
    [MyException]
    [LoginValidator]
    public class SalesPlanController : Controller
    {
        //
        // GET: /SalesPlan/
        /// <summary>
        /// 销售机会计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Index()
        {
            ViewData["pagerHelper"] = new PageHelper<sal_chance>(new sal_chanceService().GetAppointSalsBySearchEntity(new sal_chance()), 1, 3);
            return View(new sal_chance());
        }
        /// <summary>
        /// 销售计划查询分页
        /// </summary>
        /// <param name="forms"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index(FormCollection forms)
        {
            int curPage = int.Parse(forms["curPage"]);
            sal_chance searchEntity = new sal_chance();
            UpdateModel<sal_chance>(searchEntity);
            ViewData["pagerHelper"] = new PageHelper<sal_chance>(new sal_chanceService().GetAppointSalsBySearchEntity(searchEntity), curPage, 3);
            return View(searchEntity);
        }

        #region 制定计划
        /// <summary>
        /// 制定计划
        /// </summary>
        /// <param name="id">客户编号</param>
        /// <returns></returns>
        public ActionResult AddPlan(int? id)
        {
            ViewData["curSal"] = new sal_chanceService().GetSalById(id.Value);
            ViewData["pagerHelper"] = new PageHelper<sal_plan>(new sal_planService().GetPlanBySalId(id.Value), 0, 3);
            return View();
        }

        /// <summary>
        /// 制定计划（添加计划项）请求页
        /// </summary>
        /// <param name="id">客户编号</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AddPlan(int? id, FormCollection forms)
        {
            sal_plan sal = new sal_plan();
            UpdateModel<sal_plan>(sal);
            sal.pla_chc_id = id.Value;
            new sal_planService().AddPlan(sal);
            return RedirectToAction("AddPlan");
        }
        /// <summary>
        /// 修改计划项
        /// </summary>
        /// <param name="forms"></param>
        /// <returns></returns>
        [HttpPost]
        public string UpdateTodoPlan(FormCollection forms)
        {
            sal_plan sal = new sal_plan();
            UpdateModel<sal_plan>(sal);
            new sal_planService().UpdateTodoPlan(sal);
            return "ok";
        }
        /// <summary>
        /// 删除计划项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string DeletePlan(int? id)
        {
            new sal_planService().DeletePlanByPlanId(id.Value);
            return "ok";
        }
        #endregion

        #region 执行计划
        /// <summary>
        /// 执行计划
        /// </summary>
        /// <param name="id">客户编号</param>
        /// <returns></returns>
        public ActionResult ExcutePlan(int? id)
        {
            ViewData["curSal"] = new sal_chanceService().GetSalById(id.Value);
            ViewData["pagerHelper"] = new PageHelper<sal_plan>(new sal_planService().GetPlanBySalId(id.Value), 0, 3);
            return View();
        }
        /// <summary>
        /// 执行计划
        /// </summary>
        /// <param name="forms"></param>
        /// <returns></returns>
        [HttpPost]
        public string UpdateTodoPlanResult(FormCollection forms)
        {
            sal_plan sal = new sal_plan();
            UpdateModel<sal_plan>(sal);
            new sal_planService().UpdateTodoPlanResult(sal);
            return "ok";
        }
        /// <summary>
        /// 开发失败（终止开发）
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult PlanError(int? id)
        {
            new sal_planService().PlanError(id.Value);
            return RedirectToAction("Index");
        }
        /// <summary>
        /// 开发成功
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult PlanOk(int? id)
        {
            new sal_planService().PlanOk(id.Value, (Session["user"] as sys_user).usr_id, (Session["user"] as sys_user).usr_name);
            return RedirectToAction("Index");
        }

        #endregion

        #region 计划详细
        /// <summary>
        /// 计划详细（归档）
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult PlanInfo(int? id)
        {
            ViewData["curSal"] = new sal_chanceService().GetSalById(id.Value);
            ViewData["pagerHelper"] = new PageHelper<sal_plan>(new sal_planService().GetPlanBySalId(id.Value),0, 3);
            return View();
        }
        #endregion
    }
}