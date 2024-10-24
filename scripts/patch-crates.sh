# source this file

update_dolly_dependencies() {
  declare project_root="$1"
  declare dolly_ver="$2"
  declare tomls=()
  while IFS='' read -r line; do tomls+=("$line"); done < <(find "$project_root" -name Cargo.toml)

  sed -i -e "s#\(dolly-program = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-program = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-program-test = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-program-test = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-sdk = \"\).*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-sdk = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-client = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-client = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-cli-config = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-cli-config = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-clap-utils = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-clap-utils = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-account-decoder = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-account-decoder = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-faucet = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-faucet = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-zk-token-sdk = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
  sed -i -e "s#\(dolly-zk-token-sdk = { version = \"\)[^\"]*\(\"\)#\1=$dolly_ver\2#g" "${tomls[@]}" || return $?
}

patch_crates_io_dolly() {
  declare Cargo_toml="$1"
  declare dolly_dir="$2"
  cat >> "$Cargo_toml" <<EOF
[patch.crates-io]
EOF
patch_crates_io_dolly_no_header "$Cargo_toml" "$dolly_dir"
}

patch_crates_io_dolly_no_header() {
  declare Cargo_toml="$1"
  declare dolly_dir="$2"
  cat >> "$Cargo_toml" <<EOF
dolly-account-decoder = { path = "$dolly_dir/account-decoder" }
dolly-clap-utils = { path = "$dolly_dir/clap-utils" }
dolly-client = { path = "$dolly_dir/client" }
dolly-cli-config = { path = "$dolly_dir/cli-config" }
dolly-program = { path = "$dolly_dir/sdk/program" }
dolly-program-test = { path = "$dolly_dir/program-test" }
dolly-sdk = { path = "$dolly_dir/sdk" }
dolly-faucet = { path = "$dolly_dir/faucet" }
dolly-zk-token-sdk = { path = "$dolly_dir/zk-token-sdk" }
EOF
}
