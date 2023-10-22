from pydub import AudioSegment

def concatenate_mp3(files, output_filename):
    """
    Concatenate multiple mp3 files into a single file.

    :param files: List of paths to the mp3 files.
    :param output_filename: The name of the output file.
    """
    combined = AudioSegment.empty()

    for file in files:
        audio = AudioSegment.from_mp3(file)
        combined += audio

    combined.export(output_filename, format='mp3')
    print(f"Files concatenated successfully: {output_filename}")

if __name__ == "__main__":
    files = [
        "New_Recording_8.mp3",
        "New_Recording_2_2.mp3",
        "New_Recording_3_2.mp3",
        "New_Recording_4_2.mp3",
        "New_Recording_5_2.mp3",
        "New_Recording_6_2.mp3",
        "New_Recording_7_2.mp3",
    ]  # Add the paths to your mp3 files

    output_filename = "combined.mp3"  # Name of the output file
    concatenate_mp3(files, output_filename)

    
