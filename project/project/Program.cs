using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using project.Models;
using project.Hubs;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.
        builder.Services.AddRazorPages();
        builder.Services.AddSignalR();
        builder.Services.AddHttpContextAccessor();

        // Đọc chuỗi kết nối từ appsettings.json
        IConfiguration configuration = new ConfigurationBuilder()
            .SetBasePath(builder.Environment.ContentRootPath)
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        // Lấy chuỗi kết nối của cơ sở dữ liệu ElegantStyles
        string connectionString = configuration.GetConnectionString("ElegantStylesDbConnection");

        // Thêm ElegantStylesContext vào DI container
        builder.Services.AddDbContext<ElegantStylesContext>(options =>
            options.UseSqlServer(connectionString));

        // Cấu hình và kích hoạt session
        builder.Services.AddSession(options =>
        {
            options.Cookie.HttpOnly = true;
            options.Cookie.IsEssential = true;
        });

        var app = builder.Build();

        // Configure the HTTP request pipeline.
        if (!app.Environment.IsDevelopment())
        {
            app.UseExceptionHandler("/Error");
            app.UseHsts();
        }

        app.UseHttpsRedirection();
        app.UseStaticFiles();

        app.UseRouting();

        app.UseAuthorization();

        // Kích hoạt session
        app.UseSession();

        app.MapRazorPages();

        // Map Hub tại đây
        app.MapHub<ProductHub>("/productHub"); // Chú ý đặt trước app.Run()

        app.Run();

    }
}
