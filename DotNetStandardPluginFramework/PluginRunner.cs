using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace DotNetStandardPluginFramework
{
    public class PluginRunner<T> where T : class
    {
        private readonly IPluginAssemblyLocator _pluginAssemblyLocator;
        private readonly Action<T> _pluginRunAction;

        public PluginRunner(
            IPluginAssemblyLocator pluginAssemblyLocator,
            Action<T> pluginRunAction)
        {
            _pluginAssemblyLocator = 
                pluginAssemblyLocator ?? throw new ArgumentNullException(nameof(pluginAssemblyLocator));
            _pluginRunAction =
                pluginRunAction ?? throw new ArgumentNullException(nameof(pluginRunAction));
        }

        public void RunPlugins()
        {
            foreach (var instance in 
                _pluginAssemblyLocator.GetPluginAssemblies().SelectMany(GetPluginInstances))
            {
                _pluginRunAction(instance);
            }
        }

        private static IEnumerable<T> GetPluginInstances(Assembly assembly) =>
            assembly
                .ExportedTypes
                .Where(typeof(T).IsAssignableFrom)
                .Select(GetDefaultConstructor)
                .Where(c => c != null)
                .Select(c => c.Invoke(null) as T);

        private static ConstructorInfo GetDefaultConstructor(Type t) =>
            t.GetConstructor(new Type[0]);
    }
}
