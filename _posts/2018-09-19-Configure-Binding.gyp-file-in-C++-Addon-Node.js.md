---
layout: post
title: Configure binding.gyp file in C++ Addon - Node.js
bigimg: /img/path.jpg
tags: [Node.js]
---

In order to use the C++ into the Node.js, you have the three options: 
- Automation - call your C++ as a standalone app in a child process.
- Shared library - pack your C++ routines in a shared library (*.dll) and call those routines from Node.js directly through [node-ffi](https://github.com/node-ffi/node-ffi/wiki/Node-FFI-Tutorial). 
- Node.js Addon - compile your C++ code as a native Node.js module.

Before making the C++ addon, you have to learn how to configure the binding.gyp file. Because the way to configure the binding.gyp file and using the v8 library / NAN (Native Abstraction for Node.js) are the heart of making C++ addon.


Consider the binding.gyp file have common properties: 

```Javascript
{
    "targets": [
    {        
        "target_name": "name-of-builded-file", 
        'type': '<(library)',
        'msvs_guid': '5ECEC9E5-8F23-47B6-93E0-C3B328B3BE65',
        'dependencies': [
          'xyzzy',
          '../bar/bar.gyp:bar',
        ],
        'defines': [
          'DEFINE_FOO',
          'DEFINE_A_VALUE=value',
        ],
        'include_dirs': [
          '..',
        ],
        'direct_dependent_settings': {
          'defines': [
            'DEFINE_FOO',
            'DEFINE_ADDITIONAL',
          ],
          'linkflags': [
          ],
          'include_dirs': '.'
        },
        'export_dependent_settings': [
          '../bar/bar.gyp:bar',
        ],
        'sources': [
          'file1.cc',
          'file2.cc',
        ],
        'conditions': [
          ['OS=="linux"', {
            'defines': [
              'LINUX_DEFINE',
            ],
            'include_dirs': [
              'include/linux',
            ],
          }],
          ['OS=="win"', {
            'defines': [
              'WINDOWS_SPECIFIC_DEFINE',
            ],
          }, { # OS != "win",
            'defines': [
              'NON_WINDOWS_DEFINE',
            ],
          }]
        ],
      },
    ]
}
```

The top-level settings in the target include: 
- 'target_name': The name by which the target should be known, which should be unique across all .gyp files. This name will be used as the project name in the generated Visual Studio solution.

- 'type': there are three options: "executable", "shared_library", "static_library" and "none". This should almost always be set to ‘<(library)’, which allows the user to define at gyp time whether libraries are to be built static or shared. The type can be set explicitly to static_library or shared_library.

- 'dependencies': This lists other targets that this target depends on. The gyp-generated files will guarantee that the other targets are built before this target. Any library targets in the dependencies list will be linked with this target. The various settings (defines, include_dirs, etc.) listed in the direct_dependent_settings sections of the targets in this list will be applied to how this target is built and linked.

- 'defines': The C preprocessor definitions that will be passed in on compilation command lines (using -D or /D options).

- 'include_dirs': The directories in which included header files live. These will be passed in on compilation command lines (using -I or /I options).

- 'sources': The source files of this target.

- 'conditions': A block of conditions that will be evaluated to update the different settings in the target dictionary.

- 'direct_dependent_settings': This defines the settings that will be applied to other targets that directly depend on this target--that is, that list this target in their 'dependencies' setting. This is where you list the defines, include_dirs, cflags and linkflags that other targets that compile or link against this target need to build consistently.

- 'export_dependent_settings': This lists the targets whose direct_dependent_settings should be “passed on” to other targets that use (depend on) this target.


Now, we want to build C++ Addon in Node.js to a static library / shared library / executable file. The belows choice is the way to configure properties in binding.gyp. We need to completely understand the key - value of each property. 

Note: With outside library, we have two folder: "include" and "lib".

The following image is the structure of our folder. 
![./img/structure-folder-Binding.gyp.png](Structure folder in binding.gyp file)

<br>

## Make the static library / executable file / shared library
You can add property "type" in binding.gyp with the following sample: 

With static library: 

```Javascript
{
    "targets": [
        "target_name": "name-of-builded-file", 
        "type": "static_library"
        ...
    ]
}
```

Or with executable file: 

```Javascript
{
    "targets": [
        "target_name": "name-of-builded-file", 
        "type": "executable"
        ...
    ]
}
```

Or with shared library

```Javascript
{
    "targets": [
        "target_name": "name-of-builded-file", 
        "type": "shared_library"
        ...
    ]
}
```

<br>

## Including some files to build
When your project has so many *.cpp, *h files, you can separate the files into the compatible folder, such as: "./source", "./include".
Therefore, in binding.gyp file, you can configure or add source files manually. So, you have to notice about two properties: "include_dirs", and "sources".

Ex: 

```Javascript
{
    'targets': [
        'target_name': 'name-of-builded-file',
        'type': 'executable'
        'include_dirs': [
            'include',
            '<!(node -e "require(\'nan\')")' // include NAN in your project
        ],
        'sources': [ 
            './source/time.cpp',
            './source/convert.cpp'
        ]
        ...
    ]
}
```

<br>

## Dependencies between targets
GYP provides useful primitives for establishing dependencies between targets, which need to be configured in the following situations.

```Javascript
{
    'targets': [
      {
        'target_name': 'foo',
        'dependencies': [
          'libbar',
        ],
      },
      {
        'target_name': 'libbar',
        'type': '<(library)',
        'sources': [
        ],
      },
    ],
  }
```

Note that if **the library target is in a different .gyp file**, you have to specify the path to other .gyp file, relative to this .gyp file's directory:

```Javascript
{
    'targets': [
      {
        'target_name': 'foo',
        'dependencies': [
          '../bar/bar.gyp:libbar',
        ],
      },
    ],
  }
```

Adding a library often involves updating multiple .gyp files, adding the target to the approprate .gyp file (possibly a newly-added .gyp file), and updating targets in the other .gyp files that depend on (link with) the new library.

You can reference to the binding.gyp file of the node-ffi module. ([node-ffi module](https://github.com/node-ffi/node-ffi/blob/master/binding.gyp))

```Javascript 
{
  'targets': [
    {
      'target_name': 'ffi_bindings',
      'sources': [
          'src/ffi.cc'
        , 'src/callback_info.cc'
        , 'src/threaded_callback_invokation.cc'
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ],
      'dependencies': [
        'deps/libffi/libffi.gyp:ffi'
      ],
      'conditions': [
        ['OS=="win"', {
          'sources': [
              'src/win32-dlfcn.cc'
          ],
        }],
        ['OS=="mac"', {
          'xcode_settings': {
            'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
            'OTHER_CFLAGS': [
                '-ObjC++'
            ]
          },
          'libraries': [
              '-lobjc'
          ],
        }]
      ]
    }
  ]
}
```

<br>

## ## Use some outside library that have extension .lib 
In order to insert the library (*.lib) into the visual studio project, you can use the two properties: 'libraries', 'link_settings'. 

```Javascript
{
    'targets': [
        'target_name': 'name-of-builded-file',
        'type': 'executable'
        'include_dirs': [
            'include',
            '<!(node -e "require(\'nan\')")' // include NAN in your project
        ],
        'sources': [ 
            './source/time.cpp',
            './source/convert.cpp'
        ], 
        'libraries': [
            'your_lib.lib', 
            ...
        ], 
        'link_settings': {
            'library_dirs': [
                'lib_folder_1/lib', 
                'lib_folder_2/lib'
            ]
        }
        ...
    ]
}
```

To the library that it can be got from the somewhere, you can turn this library into the new node module. From this module, you will return the path of "include" folder and "lib" folder of these libraries. 

<br>

## Adding properties for setting in Visual Studio

```Javascript
{
    "targets": [
    {        
        "target_name": "name-of-builded-file", 
        'type': '<(library)',        
        ...        
        'conditions': [
          ['OS=="linux"', {
            'defines': [
              'LINUX_DEFINE',
            ],
            'include_dirs': [
              'include/linux',
            ],
          }],
          ['OS=="win"', {
            'msvs_settings': {
                'VCCLCompilerTool': {
                        "AdditionalOptions": [
                        "/execution-charset:utf-8",
                        "/source-charset:utf-8",
                        "/EHsc",
                        "/GR"
                    ], 
                    'WarningLevel': 4,
                    'ExceptionHandling': 1,
                    'DisableSpecificWarnings': [
                        4100, 4127, 4201, 4244, 4267, 4506, 4611, 4714, 4512
                    ]
                },
                'VCLibrarianTool': {
                },
                'VCLinkerTool': {
                    'GenerateDebugInformation': 'true',
                    "AdditionalOptions": [ '/ignore:4267' ], 
                    'DisableSpecificWarnings': [ '4990', '4530' ],
                },
            },
            'defines': [
              'WINDOWS_SPECIFIC_DEFINE',
            ],
          }], 
          ['OS' == "mac", {
            'xcode_settings': {
                'OTHER_LDFLAGS': [
                    '-fsanitize=address', 
                    '-Wl,-bind_at_load'
                ], 
                'GCC_ENABLE_CPP_RTTI': 'YES',
                'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
                'MACOSX_DEPLOYMENT_TARGET':'10.8',
                'CLANG_CXX_LIBRARY': 'libc++',
                'CLANG_CXX_LANGUAGE_STANDARD':'c++11',
                'GCC_VERSION': 'com.apple.compilers.llvm.clang.1_0'
            },
            'defines': [
              'NON_WINDOWS_DEFINE',
            ],
          }]
        ],
      },
    ]
}
```

<br>

## Use variables for shorting the path of folders / set state of project
To define the variables for the path of folders, you can set the following structure: 

```Javascript
{
    'variables': [
        'SOURCE_FILE%': 'E:\\prj1\\src', 
        'INCLUDE_FILE%': 'E:\\prj1\\include', 
        'change_state%': 'true', 
        'with_gif%', 'false',
        'with_jpg%': 'false'
    ]
    'targets': [
        {
            'target_name': 'name_prj', 
            ...
        }
    ]
}
```


Notice: You should read about [GYP file - User Documentation](https://gyp.gsrc.io/docs/UserDocumentation.md). It is the most detail document that I think.

You can learn how to configure through some website: [libffi.gyp](https://github.com/node-ffi/node-ffi/blob/master/deps/libffi/libffi.gyp), it is really difficult to understand. 

Thanks for your reading.

<br>

Refer: 

[GYP file - User Documentation](https://gyp.gsrc.io/docs/UserDocumentation.md)

[Program with v8 or NAN](http://luismreis.github.io/node-bindings-guide/docs/getting-started.html)

[Input Format Reference](https://gyp.gsrc.io/docs/InputFormatReference.md)

[Sample for configuring binding.gyp](https://notendur.hi.is/bjb46/vefforritun/final/node_modules/canvas/binding.gyp)

[Automating a C++ program from a Node.js web app](https://nodeaddons.com/automating-a-c-program-from-a-node-js-web-app/)

["binding.gyp" files out in the wild](https://github.com/nodejs/node-gyp/wiki/%22binding.gyp%22-files-out-in-the-wild)

[Shrine - Havard](https://open.med.harvard.edu/stash/projects/SHRINE/repos/shrine/browse?at=27eb7a491068de845b65cb5a597ddcc8407580b4)