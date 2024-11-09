using System.Net;

namespace Piscina.Data.Commons
{
    public class ServiceResponse<T> where T : class
    {
        public string? Message { get; set; }
        public T? value { get; set; }
        public HttpStatusCode StatusCode { get; set; }
    }
}
