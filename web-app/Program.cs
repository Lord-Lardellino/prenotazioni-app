using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using MudBlazor.Services;
using Piscina.Components;
using Piscina.Components.Account;
using Piscina.Data;
using Stripe;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();


builder.Services.AddMudServices();
builder.Services.AddHttpContextAccessor();
builder.Services.AddCascadingAuthenticationState();
builder.Services.AddScoped<IdentityUserAccessor>();
builder.Services.AddScoped<IdentityRedirectManager>();
builder.Services.AddScoped<AuthenticationStateProvider, IdentityRevalidatingAuthenticationStateProvider>();

builder.Services.AddAuthentication(options =>
    {
        options.DefaultScheme = IdentityConstants.ApplicationScheme;
        options.DefaultSignInScheme = IdentityConstants.ExternalScheme;
    })
    .AddIdentityCookies();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

builder.Services.AddIdentityCore<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = true)
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddSignInManager()
    .AddDefaultTokenProviders();

builder.Services.AddSingleton<IEmailSender<ApplicationUser>, IdentityNoOpEmailSender>();

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;

    var context = services.GetRequiredService<ApplicationDbContext>();

    if (context.Database.IsSqlServer())
    {
        context.Database.Migrate();
    }

}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

StripeConfiguration.ApiKey = "sk_test_51QJAo4KQtk0dIGpKhTekKbRqtJqPDWWJKgTgYqGBUzocprc1N9Tjqr1RUWB6wv5pOFqYNpIlzDZTvkk6wFELycXq00KKqXqcq8";
app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

// Add additional endpoints required by the Identity /Account Razor components.
app.MapAdditionalIdentityEndpoints();

app.Run();