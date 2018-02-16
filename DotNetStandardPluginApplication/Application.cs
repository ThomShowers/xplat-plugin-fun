using System;
using DotNetStandardPluginFramework;
using DotNetStandardPluginType;

namespace DotNetStandardPluginApplication
{
    public class Application
    {
        public static void Run(string[] args)
        {
            var pluginRunner =
                new PluginRunner<IStringGetter>(
                    new PluginDirectoryAssemblyLocator(),
                    isg => Console.WriteLine($"{isg.GetType()} => {isg.GetString()}"));

            pluginRunner.RunPlugins();
        }
    }
}
