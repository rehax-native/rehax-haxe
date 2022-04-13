workspace "rehax"
  configurations { "Debug", "Release" }
  location "out"

project "rehax-cpp-mac"
  kind "StaticLib"
  language "C++"
  cppdialect "C++20"
  location "out/rehax-cpp-mac"

  includedirs {
    ".",
  }


  filter "system:macosx"
    files {
      "rehax/components/*/cpp/*.h",
      "rehax/components/*/cpp/*.mm",
    }
    systemversion "10.9"
    
    links { 
      "Foundation.framework",
      "Cocoa.framework",
      "QuartzCore.framework",
    }

-- project "fluxe-example-text-and-button"
--   kind "WindowedApp"
--   language "C++"
--   cppdialect "C++20"
--   location "dev/example-text-and-button"

--   includedirs {
--     ".",
--     "./third_party/skia",
--   }

--   sysincludedirs {
--     "/usr/local/lib/haxe/lib/hxcpp/4,2,1/include",
--   }

--   links {
--     "fluxe-cpp-core",
--   }
--   linkoptions {
--     "../../examples/text_and_button/out/liboutput.a",
--   }

--   files {
--     "examples/text_and_button/**.hx",
--     "examples/text_and_button/main.cpp",
--   }

--   filter 'files:**.hx'
--     buildcommands {
--       "cd ../../examples/text_and_button && MACOSX_DEPLOYMENT_TARGET=\"10.15\" haxe textAndButton.hxml -D FLUXE_CORE_LIB=\"../../../dev/fluxe-cpp-core/bin/Debug/libfluxe-cpp-core.a\""
--     }
--     buildoutputs {
--       "examples/text_and_button/out/liboutput.a"
--     }

--   filter "system:macosx"
--     systemversion "10.9"
    
--     libdirs {
--       "third_party/skia/out/Static"
--     }

--     links { 
--       "Foundation.framework",
--       "Cocoa.framework",
--       "QuartzCore.framework",
--       "skia",
--       "skparagraph",
--       "skshaper",
--       "skunicode",
--     }

-- project "fluxe-example-layout"
--   kind "WindowedApp"
--   language "C++"
--   cppdialect "C++20"
--   location "dev/example-layout"

--   includedirs {
--     ".",
--     "./third_party/skia",
--   }

--   sysincludedirs {
--     "/usr/local/lib/haxe/lib/hxcpp/4,2,1/include",
--   }

--   links {
--     "fluxe-cpp-core",
--   }
--   linkoptions {
--     "../../examples/layouts/out/liboutput.a",
--   }

--   files {
--     "examples/layouts/**.hx",
--     "examples/layouts/main.cpp",
--   }

--   filter 'files:**.hx'
--     buildcommands {
--       "cd ../../examples/layouts && MACOSX_DEPLOYMENT_TARGET=\"10.15\" haxe layout.hxml -D FLUXE_CORE_LIB=\"../../../dev/fluxe-cpp-core/bin/Debug/libfluxe-cpp-core.a\""
--     }
--     buildoutputs {
--       "examples/layouts/out/liboutput.a"
--     }

--   filter "system:macosx"
--     systemversion "10.9"
    
--     libdirs {
--       "third_party/skia/out/Static"
--     }

--     links { 
--       "Foundation.framework",
--       "Cocoa.framework",
--       "QuartzCore.framework",
--       "skia",
--       "skparagraph",
--       "skshaper",
--       "skunicode",
--     }