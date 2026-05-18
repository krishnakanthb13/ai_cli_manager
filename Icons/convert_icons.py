try:
    from PIL import Image
except ImportError:
    print("[ERROR] Pillow is not installed. Run: pip install Pillow")
    raise SystemExit(1)

import os
import glob

MAX_IMAGE_DIMENSION = 4096

def fix_icons(folder_path):
    print(f"Checking {folder_path} for images...")

    extensions = ['*.png', '*.jpg', '*.jpeg']
    image_files = []
    for ext in extensions:
        image_files.extend(glob.glob(os.path.join(folder_path, ext)))

    if not image_files:
        print("No image files found.")
        return

    print(f"Found {len(image_files)} image files. Converting...")

    count = 0
    failed = 0
    icon_sizes = [(256, 256), (128, 128), (64, 64), (48, 48), (32, 32), (16, 16)]

    for img_path in image_files:
        base = os.path.basename(img_path)
        try:
            ico_path = os.path.splitext(img_path)[0] + "_v2.ico"

            img = Image.open(img_path)

            if max(img.size) > MAX_IMAGE_DIMENSION:
                print(f"[SKIP] {base}: image too large ({img.size[0]}x{img.size[1]}), max {MAX_IMAGE_DIMENSION}px")
                failed += 1
                continue

            img = img.convert("RGBA")

            max_size = max(img.size)
            square_img = Image.new("RGBA", (max_size, max_size), (0, 0, 0, 0))
            offset = ((max_size - img.size[0]) // 2, (max_size - img.size[1]) // 2)
            square_img.paste(img, offset)

            resampled_icons = [
                square_img.resize(size, Image.Resampling.LANCZOS)
                for size in icon_sizes
            ]

            resampled_icons[0].save(
                ico_path,
                format='ICO',
                sizes=icon_sizes,
                append_images=resampled_icons[1:]
            )

            print(f"[OK] {base} -> {os.path.basename(ico_path)}")
            count += 1

        except (OSError, SyntaxError) as e:
            print(f"[ERROR] {base}: {e}")
            failed += 1
        except Exception as e:
            print(f"[ERROR] {base}: unexpected error: {e}")
            failed += 1

    print(f"\nSummary: {count} converted, {failed} failed/skipped.")

if __name__ == "__main__":
    fix_icons(os.getcwd())
