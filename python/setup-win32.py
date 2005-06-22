from distutils.core import setup, Extension

setup(name='Redland RDF Application Framework bindings',
	version='1.0.2.1',
	description='Redland RDF Application Framework bindings 1.0.2.1',
	packages=['RDF'],
	ext_modules=[Extension('RDF.Redland', 
		['Redland_wrap.c'], 
		define_macros = [('REDLAND_POST_I', '1'),('WIN32', '1')],
		include_dirs=['../../redland/librdf','../../redland/raptor','../../redland/rasqal','.'], 
		libraries=["../../redland/rasqal/win32/Release/rasqal", "../../redland/raptor/win32/Release/raptor", "../../redland/librdf/win32/Release/librdf"])],
		data_files=[("lib/site-packages/RDF", 
			["../../redland/librdf/win32/Release/librdf.dll",
			"../../redland/raptor/win32/Release/raptor.dll",
			"../../redland/rasqal/win32/Release/rasqal.dll",
			"../../curl-7.13.2/lib/Release/libcurl.dll",
			"../../bdb/libdb43.dll",
			"../extra_dlls/iconv.dll",
			"../extra_dlls/zlib1.dll",
			"../extra_dlls/libmysql.dll",
			"../extra_dlls/libxslt.dll",
			"../extra_dlls/libxml2.dll"])],
	)
