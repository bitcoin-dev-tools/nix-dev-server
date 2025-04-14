{
  description = "Bitcoin development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    binDirs = [ "./build/bin" "./build/bin/qt" ];
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        # Essential build tools
        boost
        ccache
        clang-tools_19
        clang_19
        cmake
        gcc14
        libevent
        pkg-config
        sqlite

        # Optional build dependencies
        capnproto
        db4
        qrencode
        zeromq

        # Tests
        hexdump

        # Depends
        byacc

        # Functional tests & linting
        python312
        python312Packages.autopep8
        python312Packages.flake8
        python312Packages.mypy
        python312Packages.pyzmq
        python312Packages.requests

        # Benchmarking
        python310Packages.pyperf

        # Debugging
        gdb

        # Tracing
        libsystemtap
        linuxPackages.bcc
        linuxPackages.bpftrace

        # Bitcoin-qt
        qt5.qtbase
        qt5.qttools
      ];

      # Fixes xcb plugin error when trying to launch bitcoin-qt
      QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms";

      shellHook = ''
        BCC_EGG=${pkgs.linuxPackages.bcc}/${pkgs.python3.sitePackages}/bcc-${pkgs.linuxPackages.bcc.version}-py3.${pkgs.python3.sourceVersion.minor}.egg
        if [ -f $BCC_EGG ]; then
          export PYTHONPATH="$PYTHONPATH:$BCC_EGG"
        else
          echo "The bcc egg $BCC_EGG does not exist. Maybe the python or bcc version is different?"
        fi

        # Use clang by default
        export CC=clang
        export CXX=clang++

        # Use Ninja generator 🥷
        export CMAKE_GENERATOR="Ninja"

        # Use mold linker 🦠
        export LDFLAGS="-fuse-ld=mold"

        # Misc bitcoin options
        export LSAN_OPTIONS="suppressions=$(pwd)/test/sanitizer_suppressions/lsan"
        export TSAN_OPTIONS="suppressions=$(pwd)/test/sanitizer_suppressions/tsan:halt_on_error=1:second_deadlock_stack=1"
        export UBSAN_OPTIONS="suppressions=$(pwd)/test/sanitizer_suppressions/ubsan:print_stacktrace=1:halt_on_error=1:report_error_type=1"

        # Add output build dir to $PATH
        export PATH=$PATH:${builtins.concatStringsSep ":" binDirs}
      '';
    };
  };
}
