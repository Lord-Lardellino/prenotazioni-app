using Microsoft.EntityFrameworkCore;

namespace Piscina.Data
{
    public interface IApplicationDbContext
    {
        DbSet<ApplicationUser>? User { get; set; }
    }
}
