import struct
import common

def WriteBoltBsu(info, bolt_img, bsu_img):
  common.ZipWriteStr(info.output_zip, "bolt-bb.bin", bolt_img)
  common.ZipWriteStr(info.output_zip, "android_bsu.elf", bsu_img)

  info.script.Print("Writing bolt ...")
  info.script.AppendExtra('package_extract_file("bolt-bb.bin", "/tmp/bolt-bb.bin");')
  info.script.AppendExtra("""avko.flash_bolt("/tmp/bolt-bb.bin");""")

  info.script.Print("Writing android bsu...")
  info.script.WriteRawImage("/bsu", "android_bsu.elf")

def FullOTA_InstallEnd(info):
  try:
    bolt_img = info.input_zip.read("RADIO/bolt-bb.bin")
    bsu_img = info.input_zip.read("RADIO/android_bsu.elf")
  except KeyError:
    print "no bolt-bb.bin or android_bsu.elf in target_files; skipping install"
  else:
    WriteBoltBsu(info, bolt_img, bsu_img)

def IncrementalOTA_InstallEnd(info):
  try:
    target_bolt_img = info.target_zip.read("RADIO/bolt-bb.bin")
    target_bsu_img = info.target_zip.read("RADIO/android_bsu.elf")
    try:
      source_bolt_img = info.source_zip.read("RADIO/bolt-bb.bin")
      source_bsu_img = info.source_zip.read("RADIO/android_bsu.elf")
    except KeyError:
      source_bolt_img = None
      source_bsu_img = None

    if (target_bolt_img == source_bolt_img and target_bsu_img == source_bsu_img):
      print "bolt and bsu unchanged; skipping"
    else:
      WriteBoltBsu(info, target_bolt_img, target_bsu_img)

  except KeyError:
    print "No bolt or bsu found in target_files; skipping install"
