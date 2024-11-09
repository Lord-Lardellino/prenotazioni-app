using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Piscina.Data.Services.Interfaces;
using Stripe.Checkout;

namespace Piscina.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StripeController : ControllerBase
    {


        private readonly IStripeService? stripeService;

        public StripeController(IStripeService? stripeService)
        {
            this.stripeService = stripeService;
        }


        [HttpPost("create-checkout-session")]
        public ActionResult CreateCheckoutSession()
        {


            var domain = "http://localhost:44392";
            var options = new SessionCreateOptions
            {
                LineItems = new List<SessionLineItemOptions>
                {
                  new SessionLineItemOptions
                  {
                    // Provide the exact Price ID (for example, pr_1234) of the product you want to sell
                    Price = "{{PRICE_ID}}",
                    Quantity = 1,
                  },
                },
                Mode = "payment",
                SuccessUrl = domain + "/",
                CancelUrl = domain + "/",
            };
            var service = new SessionService();
            Session session = service.Create(options);

            Response.Headers.Add("Location", session.Url);

            return Ok();
        }
    }
}
