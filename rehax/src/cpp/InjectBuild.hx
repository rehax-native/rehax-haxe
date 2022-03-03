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

		var link = [];
		link.push('<compilerflag value="-std=c++20" />');
		// link.push('<compilerflag value="-stdlib=libc++" />');
		//  <files id="haxe">$cflags</files>

		var location = Context.definedValue("REHAX_BACKEND_LIB");
		link.push('<lib name="$location" />');
		// location = Context.definedValue("REHAX_YOGA_LIB");
		// location = location.split(" ")[0];
		// link.push('<lib name="$location" />');
		link.push('<vflag name="-framework" value="QuartzCore"/>');

		var buildXml = {
			expr: EConst(CString('
                                   <set name="MAC_USE_CURRENT_SDK" value="1" if="macos" />
                                   <set name="HXCPP_GCC" value="1" if="macos" />
                                   <set name="HXCPP_M64" value="1" if="macos" />
                                   <target id="haxe" tool="linker" toolid="exe">${link.join("\n")}</target>')),
			pos: _pos
		};
		_class.get().meta.add(":buildXml", [buildXml], _pos);

		return Context.getBuildFields();
	}
}