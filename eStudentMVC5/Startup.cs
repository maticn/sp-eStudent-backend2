﻿using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(eStudentMVC5.Startup))]
namespace eStudentMVC5
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
