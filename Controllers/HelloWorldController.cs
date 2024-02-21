using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Mvc;

namespace MovieMVC.Controllers
{
    public class HelloWorldController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Welcome(string name, int numTimes = 1)
        {
            ViewData["Messages"] = "Hello " + name;
            ViewData["NumTimes"] = "NumTimes " + numTimes;
            return View();
        }
    }
}