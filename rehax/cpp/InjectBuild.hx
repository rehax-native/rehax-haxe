package rehax.cpp;

import haxe.macro.Expr.ExprDef.EConst;
import haxe.macro.Expr.Field;
import haxe.macro.Context;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.Process;

class InjectBuild {
	macro public static function config():Array<Field> {
		var _pos = Context.currentPos();
		var _class = Context.getLocalClass();
		var _info = Context.getPosInfos(_pos);
		if (_class == null) {
			return Context.getBuildFields();
		}

		// var sourcePath = Path.directory(_info.file);
		// if (!Path.isAbsolute(sourcePath)) {
		// 	sourcePath = Path.join([Sys.getCwd(), sourcePath]);
		// }
		// sourcePath = Path.normalize(sourcePath);

		var location = Context.definedValue("REHAX_INCLUDE");
		var compilerFlags = ['<compilerflag value="-std=c++20" />'];
		var runtimeCompilerFlags = [];
		if (location != null && location.length > 0) {
			compilerFlags.push('<compilerflag value="-I$location" />');
			compilerFlags.push('<compilerflag value="/MDd" if="windows" />');
			runtimeCompilerFlags.push('<compilerflag value="/MDd" if="windows" />');
		} else {
			trace("REHAX_INCLUDE not defined. This is necessary in order to compile rehax for cpp");
		}

		var link = [];
		location = Context.definedValue("REHAX_BACKEND_LIB");
		if (location != null && location.length > 0) {
			link.push('<lib name="$location" />');
			link.push('<vflag name="-framework" value="QuartzCore"/>');
		} else {
			trace("REHAX_BACKEND_LIB not defined. This is necessary in order to compile rehax for cpp");
		}
		// location = Context.definedValue("REHAX_YOGA_LIB");
		// location = location.split(" ")[0];
		// link.push('<lib name="$location" />');

		var xml = '
		<set name="MAC_USE_CURRENT_SDK" value="1" if="macos" />
		<set name="HXCPP_GCC" value="1" if="macos" />
		<set name="HXCPP_M64" value="1" if="macos" />
		<files id="haxe">${compilerFlags.join("\n")}</files>
		<files id="runtime">${runtimeCompilerFlags.join("\n")}</files>
		<files id="__lib__">${runtimeCompilerFlags.join("\n")}</files>
		';
		// <target id="haxe" tool="linker" toolid="exe">${link.join("\n")}</target>

		var buildXml = {
			expr: EConst(CString(xml)),
			pos: _pos
		};
		_class.get().meta.add(":buildXml", [buildXml], _pos);

		return Context.getBuildFields();
	}
}