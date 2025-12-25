from flask import Flask, jsonify, request

app = Flask(__name__)

# GETリクエストのテスト用エンドポイント
@app.route('/test-get', methods=['GET'])
def test_get():
    # Rの httr コードに合わせたレスポンス構造
    data = {
        "full_name": "local-test-server/httr-test",
        "description": "これはローカルのPythonサーバーから返されたテストデータです。",
        "status": "success"
    }
    return jsonify(data)

# POSTリクエストのテスト用エンドポイント
@app.route('/test-post', methods=['POST'])
def test_post():
    # 送られてきたJSONデータを取得
    received_data = request.get_json()
    print(f"Rからデータを受信しました: {received_data}")

    # 受け取ったデータをそのまま返す（Echoレスポンス）
    return jsonify({
        "message": "データを受信しました",
        "received": received_data
    })

if __name__ == '__main__':
    # ポート5000番でサーバーを起動
    app.run(port=5000)