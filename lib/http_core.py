#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2017/12/13 18:31
# @Author  : youqingkui
# @File    : http_core.py
# @Desc    :

import os
import requests

class MiWiFi(object):
    def __init__(self, token, appid, device_id):
        self.token = token
        self.appid = appid
        self.device_id = device_id
        self.base_url = 'https://www.gorouter.info'

    def __get_auth_params(self):
        params = {
            'appId': self.appid,
            'clientId': self.appid,
            'deviceId': self.device_id,
            'token': self.token
        }
        return params

    def __request_api(self, api_url, params=None, method='GET'):
        req_params = self.__get_auth_params()
        if isinstance(params, dict):
            req_params.update(params)
        request_url = self.base_url + api_url
        if method == 'POST':
            res = requests.post(request_url, data=req_params)
        else:
            res = requests.get(request_url, params=req_params)
        res_json = res.json()
        print(res_json)
        return res_json

    def get_status(self):
        """
        获取路由器状态
        :return:
        """
        api_url = '/api-third-party/device'
        res = self.__request_api(api_url)
        return res

    def get_connected_device(self):
        """
        获取连接设备
        :return:
        """
        api_url = '/api-third-party/service/datacenter/get_connected_device'
        res = self.__request_api(api_url)
        return res

    def get_router_info(self):
        """
        获取路由器信息
        :return:
        """
        api_url = '/api-third-party/service/datacenter/get_router_info'
        res = self.__request_api(api_url)
        return res

    def get_router_mac(self):
        """
        获取路由器mac地址
        :return:
        """
        api_url = '/api-third-party/service/datacenter/get_router_mac'
        res = self.__request_api(api_url)
        return res

    def download_file(self, file_url):
        """
        下载一个指定的Url到路由器
        :param url:
        :return:
        """
        api_url = '/api-third-party/service/datacenter/download_file'
        download_param = {
            'url':file_url
        }
        res = self.__request_api(api_url, params=download_param)
        return res

    def download_info(self, downloadId):
        """
        根据id查询下载项目的信息
        :param downloadId:
        :return:
        """
        api_url = '/api-third-party/service/datacenter/download_info'
        query_param = {
            'downloadId':downloadId
        }
        res = self.__request_api(api_url, params=query_param)
        return res



if __name__ == '__main__':
    token = os.getenv('miwifi_token')
    appid = os.getenv('miwifi_appid')
    device_id = os.getenv('miwifi_device_id')
    miwifi = MiWiFi(token=token, appid=appid, device_id=device_id)
    # miwifi.get_router_info()
    # miwifi.download_file('https://download-cdn.resilio.com/stable/osx/Resilio-Sync.dmg')
    miwifi.download_info('151317378458643914')
    miwifi.download_info('151317362874932591')
