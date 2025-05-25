#!/bin/bash

# Root project
ROOT="blueberrybush_kernel_project"

# Daftar struktur direktori dan file
declare -A STRUCTURE=(
  ["README.md"]=""
  ["Makefile"]=""
  ["berry.abcf"]=""
  ["berry.ld"]=""

  ["bootloader/"]="berryboot.c uefi_interface.c mbr_stub.asm"

  ["include/nexoseed/"]="core.h interrupt.h syscall.h hook.h ipc.h dmesghook initmode.h"
  ["include/rn_kernel/"]="rn_core.h rn_event.h rn_debug.h rn_policy.h"

  ["source/"]="core.c interrupt.c syscall.c ipc.c hook.c initmode.c util.c"

  ["rn_kernel/"]="core.c event.c dmesghook.h debug.c rn_abtp.c security.c"

  ["drivers/abfsb/"]="abfsb.h abfsb.c"
  ["drivers/console/"]="console.h console.c"

  ["berry/befb/"]="befb_loader.c befb_handler.c befb_utils.c"
  ["berry/bootloadermanager/"]="main.c boot_config.c boot_config.h boot_device.c boot_device.h boot_entry.c boot_entry.h boot_efi.c boot_efi.h boot_init.c boot_init.h boot_parser.c boot_parser.h"

  ["debug/"]="trace.c toggle.c stub.c"

  ["image/"]="berry.befb berryboot.efi berry.iso"

  ["tests/"]="core_test.c initmode_test.c event_test.c"

  ["docs/"]="design.md bootflow.md api_reference.md changelog.md"
)

# Membuat root
mkdir -p "$ROOT"

# Fungsi untuk cek dan tambahkan file .dummy jika folder kosong
add_dummy_if_empty() {
  local dir="$1"
  if [ -d "$dir" ] && [ -z "$(ls -A "$dir")" ]; then
    touch "$dir/.dummy"
  fi
}

# Membuat direktori dan file sesuai struktur
for dir in "${!STRUCTURE[@]}"; do
  full_dir="$ROOT/$dir"

  # Jika direktori, buatkan
  mkdir -p "$full_dir"

  # Buat file dalam direktori jika ada
  for file in ${STRUCTURE[$dir]}; do
    touch "$full_dir/$file"
  done

  # Tambahkan .dummy jika tidak ada file dibuat
  add_dummy_if_empty "$full_dir"
done

echo "Struktur proyek berhasil dibuat."
