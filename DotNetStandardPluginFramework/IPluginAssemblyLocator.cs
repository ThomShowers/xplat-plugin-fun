using System.Collections.Generic;
using System.Reflection;

namespace DotNetStandardPluginFramework
{
    public interface IPluginAssemblyLocator
    {
        IEnumerable<Assembly> GetPluginAssemblies();
    }
}
