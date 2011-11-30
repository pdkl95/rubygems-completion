# bash completion for the rubygems "gem" program
#
# Copyright C 2011 Brent Sanders <git@thoughtnoise.net>
#  -> Derived losely from "git-completion.sh" in the git-sh
#     package, copyright C 2006,2007 Shawn O. Pearce <spearce@spearce.org>
#      -> Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
#         Distributed under the GNU General Public License, version 2.0.
#
# This was designed around rubygems 1.8.10 and the options may not exactly
# match other versions.


if type -p gem >/dev/null ; then
    function __gemcomp {
        local all c s=$'\n' IFS=' '$'\t'$'\n'
        local cur="${COMP_WORDS[COMP_CWORD]}"
        if [ $# -gt 2 ]; then
            cur="$3"
        fi
        for c in $1; do
            case "$c$4" in
                --*=*) all="$all$c$4$s" ;;
                *.)    all="$all$c$4$s" ;;
                *)     all="$all$c$4 $s" ;;
            esac
        done
        IFS=$s
        COMPREPLY=($(compgen -P "$2" -W "$all" -- "$cur"))
        return
    }

    function __gem_complete_file {
        COMPREPLY=()
    }

    function __gem_complete_file_gem {
        __gem_complete_file
    }

    function __gem_complete_file_gemspec {
        __gem_complete_file
    }

    function __gem_complete_gemname {
        __gemcomp "$(gem list --no-details --no-versions)"
    }

    function __gem_complete_gemnameversion {
        __gem_complete_gemname
    }

    function __gem_commands {
        #gem help commands | sed -e '/^  /! d; s/^ *//; s/ .*$//'
        echo "build cert check cleanup contents dependency environment fetch generate_index help install list lock outdated owner pristine push query rdoc search server sources specification stale uninstall unpack update which"
    }

    function __gem_stdopt_short {
        echo "-h -V -q"
    }

    function __gem_stdopt_long {
        echo "--help --verbose --no-verbose --quiet --config-file= --backtrace --debug"
    }

    function __gem_options {
        local cur="${COMP_WORDS[COMP_CWORD]}" short="$1" long="$2"
        shift 2
        case "$cur" in
            --*)
                __gemcomp "$(__gem_stdopt_long) ${long}"
                return
                ;;
            -*)
                __gemcomp "$(__gem_stdopt_short) ${short}"
                return
                ;;
        esac
        COMPREPLY=()
    }

    function __gem_localremote_options {
        local short="$1" long="$2"
        shift 2
        __gem_options "-l -r -b -B -p ${short}" "\
            --local
            --remote
            --both
            --bulk-threshold=
            --clear-sources
            --source=
            ${long}"
    }

    function __gem_installupdate_options {
        local short="$1" long="$2"
        shift 2
        __gem_localremote_options "-i -n -d -E -f -w -P -W ${short}" "\
            --install-dir=
            --bindir=
            --rdoc --no-rdoc
            --ri --no-ri
            --env-shebang --no-env-shebang
            --force --no-force
            --wrappers --no-wrappers
            --trust-policy=
            --ignore-dependencies
            --include-dependencies
            --format-executable --no-format-executable
            --user-install --no-user-install
            --development
            --conservative
            ${long}"
    }

    function __gem_gemnames_or_options {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options "$@" ;;
            *)  __gem_complete_gemname ;;
        esac
    }

    function __gem_gemnames_or_localremote_options {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_localremote_options "$@" ;;
            *)  __gem_complete_gemname ;;
        esac
    }


    function __gem_gemnames_or_installupdate_options {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_installupdate_options "$@" ;;
            *)  __gem_complete_gemname ;;
        esac
    }

    function __gem_files_or_options {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options "$@" ;;
            *)  __gem_complete_file ;;
        esac
    }


    function _gem_build {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options "$@" ;;
            *)  __gem_complete_file_gemspec ;;
        esac
    }

    function _gem_cert {
        __gem_options '-a -l -r -b -C -K -s' '\
            --add=
            --list
            --remove=
            --build=
            --certificate=
            --private-key=
            --sign='
    }

    function _gem_check {
        __gem_options '-a -v' '\
            --verify=
            --alien
            --version='
    }

    function _gem_cleanup {
        __gem_gemnames_or_options '-d' '--dryrun'
    }

    function _gem_contents {
        __gem_gemnames_or_options '-v -s -l' '\
            --version=
            --all
            --spec-dir=
            --lib-only --no-lib-only
            --prefix --no-prefix'
    }

    function _gem_dependency {
        __gem_gemnames_or_localremote_options '-v -R' '\
            --version=
            --platform=
            --prerelease --no-prerelease
            --reverse-dependencies --no-reverse-dependencies
            --pipe'
    }

    function _gem_environment {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options ;;
            *)  __gemcomp "packageversion gemdir gempath version remotsources platform" ;;
        esac
    }

    function _gem_fetch {
        __gem_gemnames_or_options '-v -B -p', '\
            --version=
            --platform=
            --prerelease --no-prerelease
            --bulk-threshold=
            --http-proxy --no-http-proxy
            --source='
    }

    function _gem_generate_index {
        __gem_options '-d' '\
            --directory=
            --legacy --no-legacy
            --modern --no-modern
            --update
            --rss-gems-host=
            --rss-host=
            --rss-title='
    }

    function _gem_help {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options ;;
            *)  __gemcomp "commands examples ${__gem_commandlist}" ;;
        esac
    }

    function _gem_install {
        __gem_gemnames_or_installupdate_options '-v' '\
            --platform=
            --version=
            --prerelease --no-prerelease'
    }

    function _gem_list {
        __gem_options "-i -v -d -a" "\
            --installed --no-installed
            --version
            --details --no-details
            --versions --no-versions
            --all"
    }

    function _gem_lock {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options '-s' '--strict --no-strict' ;;
            *)  __gem_complete_gemnameversion ;;
        esac
    }

    function _gem_outdated {
        __gem_localremote_options '' '--platform='
    }

    function _gem_owner {
        __gem_options '-k -a -r -p' '\
            --key=
            --add=
            --remote=
            --http-proxy --no-http-proxy'
    }

    function _gem_pristine {
        __gem_gemnames_or_options '-v' '\
            --all
            --extensions --no-extensions
            --version='
    }

    function _gem_push {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_options '-k -p' '--key= --host= --http-proxy --no-http-proxy' ;;
            *)  __gem_complete_file_gem ;;
        esac
    }

    function _gem_query {
        __gem_localremote_options '-i -v -n -d -a' '\
          --installed --no-installed
          --version=
          --name-matches=
          --details --no-details
          --versions --no-versions
          --all
          --prerelease --no-prerelease'
    }

    function _gem_rdoc {
        __gem_gemnames_or_options '-v' '\
            --all
            --rdoc --no-rdoc
            --ri --no-ri
            --overwrite --no-overwrite
            --version='
    }

    function _gem_search {
        case "${COMP_WORDS[COMP_CWORD]}" in
            -*) __gem_localremote_options '-i -v -d -a' '\
                    --installed --no-installed
                    --version=
                    --details --no-details
                    --versions --no-versions
                    --all
                    --prerelease --no-prerelease'
                ;;
            *) COMPREPLY=() ;;
        esac
    }

    function _gem_server {
        __gem_options '-p -d -b -l' '\
            --port=
            --dir=
            --daemon --no-daemon
            --bind=
            --launch'
    }

    function _gem_sources {
        __gem_options '-a -l -r -c -u -p' '\
            --add=
            --list
            --remove=
            --clear-all
            --update
            --http-proxy --no-http-proxy'
    }

    function _gem_specification {
        case ${COMP_CWORD} in
            2) __gem_complete_gemname ;;
            3) __gemcomp "\
                   name
                   version
                   platform
                   authors
                   autorequire
                   bindir
                   cert_chain
                   date
                   dependencies
                   description
                   email
                   executables
                   extensions
                   extra_rdoc_files
                   files
                   homepage
                   licenses
                   post_install_message
                   rdoc_options
                   require_paths
                   required_ruby_version
                   required_rubygems_version
                   requirements
                   rubyforge_project
                   rubygems_version
                   signing_key
                   specification_version
                   summary
                   test_files"
                ;;
            *) __gem_localremote_options '-v' '\
                   --version=
                   --platform=
                   --all
                   --ruby
                   --yaml
                   --marshal'
                ;;
        esac
    }

    function _gem_stale {
        __gem_options
    }

    function _gem_uninstall {
        __gem_gemnames_or_options '-a -I -x -i -n -v' '\
            --all --no-all
            --ignore-dependencies --no-ignore-dependencies
            --executables --no-executables
            --install-dir=
            --bindir=
            --user-instal --no-user-install
            --format-executable --no-format-executable
            --version=
            --platform='
    }

    function _gem_unpack {
        __gem_gemnames_or_options '-v' '--target= --spec --version='
    }

    function _gem_update {
        __gem_gemnames_or_installupdate_options '' '\
            --system
            --platform=
            --prerelease --no-prerelease'
    }

    function _gem_which {
        __gem_files_or_options '-a -g' '\
            --all --no-all
            --gems-first --no-gems-first'
    }

    function __gem {
        case "${COMP_WORDS[COMP_CWORD]}" in
            --*=*) COMPREPLY=() ;;
            --*)   __gemcomp "--help --version" ;;
            -*)    __gemcomp "-h -v" ;;
            *)     __gemcomp "$(__gem_commands)" ;;
        esac
    }

    function _gem {
        local command
        [ $COMP_CWORD -gt 1 ] && command="${COMP_WORDS[1]}"
        [ $COMP_CWORD -eq 1 ] && [ -z "$command" ] && __gem && return

        case "$command" in
            build)          _gem_build ;;
            cert)           _gem_cert ;;
            check)          _gem_check ;;
            cleanup)        _gem_cleanup ;;
            contents)       _gem_contents ;;
            dependency)     _gem_dependency ;;
            environment)    _gem_environment ;;
            fetch)          _gem_fetch ;;
            generate_index) _gem_generate_index ;;
            help)           _gem_help ;;
            install)        _gem_install ;;
            list)           _gem_list ;;
            lock)           _gem_lock ;;
            outdated)       _gem_outdated ;;
            owner)          _gem_owner ;;
            pristine)       _gem_pristine ;;
            push)           _gem_push ;;
            query)          _gem_query ;;
            rdoc)           _gem_rdoc ;;
            search)         _gem_search ;;
            server)         _gem_server ;;
            sources)        _gem_sources ;;
            specification)  _gem_specification ;;
            stale)          _gem_stale ;;
            uninstall)      _gem_uninstall ;;
            unpack)         _gem_unpack ;;
            update)         _gem_update ;;
            which)          _gem_which ;;
            *)           COMPREPLY=() ;;
        esac
    }

    complete -o default -o nospace -F _gem gem
fi