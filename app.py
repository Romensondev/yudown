from flask import Flask, render_template, request, send_file
import yt_dlp 
import os

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/formats', methods=['POST'])
def formats():
    video_url = request.form['video_url']
    

    with yt_dlp.YoutubeDL() as ydl:
        info = ydl.extract_info(video_url, download=False)
        formats = info.get('formats', [])
    
    return render_template('select_format.html', formats=formats, video_url=video_url)

@app.route('/download', methods=['POST'])
def download():
    video_url = request.form['video_url']
    format_id = request.form['format_id']

    
    ydl_opts = {
        'format': format_id,  
        'outtmpl': 'downloads/%(title)s.%(ext)s',
        'merge_output_format': 'mp4',  
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(video_url, download=True)
        filename = ydl.prepare_filename(info)

    return send_file(filename, as_attachment=True)

if __name__ == '__main__':
    os.makedirs('downloads', exist_ok=True)
    app.run(host='0.0.0.0', port=5000, debug=True)  