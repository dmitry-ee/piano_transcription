import argparse
from piano_transcription_inference import PianoTranscription, sample_rate, load_audio

parser = argparse.ArgumentParser()
parser.add_argument("mp3_path", type=str)
parser.add_argument("midi_filename", type=str)
parser.add_argument("--device", type=str, required=False, default="cuda")
parser.add_argument("--mono", type=bool, required=False, default=True)

args = parser.parse_args()

# Load audio
(audio, err) = load_audio(args.mp3_path, sr=sample_rate, mono=args.mono)

# Transcriptor
transcriptor = PianoTranscription(device=args.device)    # 'cuda' | 'cpu'

# Transcribe and write out to MIDI file
transcribed_dict = transcriptor.transcribe(audio, './result/{}'.format(args.midi_filename) )