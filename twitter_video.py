
import requests


def get_link():
    return input("Give me a twitter video link: ")


def download(url: str):
    name = url.rsplit('/')[-1]
    if("?tag" in name):
        name = name.split('?')[0]
    r = requests.get(url, allow_redirects=True)
    open(name, 'wb').write(r.content)


def main():
    payload = {'url': get_link()}
    response = requests.request("POST",
                                "http://sosmeeed.herokuapp.com:80/api/twitter/video",
                                data=payload)
    if response.status_code != 200:
        print("Can't fetch video!")
        return

    res = response.json()
    if not res["success"]:
        print("Error! Please input correct URL")
        return

    url = res["data"]["data"][0]["link"]  # use the highest quality
    print(f"Downloading ({url})...")
    download(url)


if __name__ == "__main__":
    main()