from PIL import Image
import os
import glob

def fix_icons(folder_path):
    print(f"Checking {folder_path} for images...")
    
    extensions = ['*.png', '*.jpg', '*.jpeg']
    image_files = []
    for ext in extensions:
        image_files.extend(glob.glob(os.path.join(folder_path, ext)))
    
    if not image_files:
        print("No image files found.")
        return

    print(f"Found {len(image_files)} image files. converting...")

    count = 0
    # Standard Windows icon sizes
    icon_sizes = [(256, 256), (128, 128), (64, 64), (48, 48), (32, 32), (16, 16)]

    for img_path in image_files:
        try:
            ico_path = os.path.splitext(img_path)[0] + ".ico"
            
            # Open and convert to RGBA (handles PNG transparency and JPG conversion)
            img = Image.open(img_path)
            img = img.convert("RGBA")
            
            # Use the largest dimension to make it square (contain fit)
            # Create a blank square canvas
            max_size = max(img.size)
            square_img = Image.new("RGBA", (max_size, max_size), (0, 0, 0, 0))
            
            # Paste original image in center
            offset = ((max_size - img.size[0]) // 2, (max_size - img.size[1]) // 2)
            square_img.paste(img, offset)
            
            # Generate resized versions
            resampled_icons = []
            for size in icon_sizes:
                # Use LANCZOS for high quality downsampling
                resampled = square_img.resize(size, Image.Resampling.LANCZOS)
                resampled_icons.append(resampled)
            
            # Save using the first image and appending the rest
            # This is the correct way to include multiple sizes in one ICO
            resampled_icons[0].save(
                ico_path, 
                format='ICO', 
                sizes=icon_sizes, 
                append_images=resampled_icons[1:]
            )
            
            print(f"[OK] Fixed: {os.path.basename(img_path)} -> {os.path.basename(ico_path)}")
            count += 1
            
        except Exception as e:
            print(f"[ERROR] Failed {os.path.basename(img_path)}: {str(e)}")

    print(f"\nSummary: Successfully fixed {count} files.")

if __name__ == "__main__":
    fix_icons(os.getcwd())
