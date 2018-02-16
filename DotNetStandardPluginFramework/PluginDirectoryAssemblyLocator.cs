using System.Collections.Generic;
using System.IO;
using System.Reflection;

namespace DotNetStandardPluginFramework
{
    public class PluginDirectoryAssemblyLocator : IPluginAssemblyLocator
    {
        private readonly string _pluginDirectory;

        public PluginDirectoryAssemblyLocator()
            : this(Path.GetDirectoryName(Assembly.GetEntryAssembly().Location)) { }

        public PluginDirectoryAssemblyLocator(string pluginDirectory)
        {
            _pluginDirectory = pluginDirectory;
        }

        public IEnumerable<Assembly> GetPluginAssemblies()
        {
            foreach (var file in Directory.GetFiles(_pluginDirectory))
            {
                Assembly assembly = null;
                try
                {
                    assembly = Assembly.LoadFrom(file);
                }
                catch { }

                if (assembly != null) { yield return assembly; }
            }
        }
    }
}
