using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using Piscina.Data.Entities;
using System.Reflection;
using System.Security.Claims;

namespace Piscina.Data
{
    public class ApplicationDbContext : IdentityDbContext, IApplicationDbContext
    {
        IDbContextTransaction? _currentTransaction;
        IHttpContextAccessor? _accessor;
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options, IHttpContextAccessor? accessor)
            : base(options)
        {

            _accessor = accessor;
        }

        #region DbSet

        public DbSet<ApplicationUser>? User { get; set; }

        #region DbSet


        #endregion

        #region Topologiche



        #endregion


        #endregion


        #region Transactions

        public async Task BeginTransactionAsync()
        {
            if (_currentTransaction != null)
            {
                return;
            }

            _currentTransaction = await base.Database.BeginTransactionAsync();
        }

        public async Task CommitAsync()
        {
            try
            {
                await SaveChangesAsync();
            }
            catch (Exception)
            {
                RollBackTransactions();
                throw;
            }
            finally
            {
                if (_currentTransaction != null)
                {
                    _currentTransaction?.Commit();
                    _currentTransaction.Dispose();
                    _currentTransaction = null;
                }

            }
        }

        public void RollBackTransactions()
        {
            try
            {
                _currentTransaction?.Rollback();
            }
            finally
            {
                if (_currentTransaction != null)
                {
                    _currentTransaction.Dispose();
                    _currentTransaction = null;
                }
            }
        }

        #endregion

        #region Override

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = new CancellationToken())
        {
            try
            {
                foreach (var entry in ChangeTracker.Entries<Base>())
                {
                    switch (entry.State)
                    {
                        case EntityState.Added:
                            entry.Entity.UtenteCreazione = _accessor.HttpContext?.User == null ? "Anonymous" : _accessor.HttpContext?.User.FindFirst(x => x.Type == ClaimTypes.NameIdentifier).Value;
                            entry.Entity.DataCreazione = DateTime.ParseExact(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"), "dd-MM-yyyy HH:mm:ss", null);
                            break;
                        case EntityState.Modified:
                            entry.Entity.UtenteUltimaModifica = _accessor.HttpContext?.User == null ? "Anonymous" : _accessor.HttpContext?.User.FindFirst(x => x.Type == ClaimTypes.NameIdentifier).Value;
                            entry.Entity.DataUltimaModifica = DateTime.ParseExact(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"), "dd-MM-yyyy HH:mm:ss", null);
                            break;
                    }
                }
                return base.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {

                throw;
            }



        }

        protected override void OnModelCreating(ModelBuilder builder)
        {

            builder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            base.OnModelCreating(builder);
        }


        #endregion
    }
}
