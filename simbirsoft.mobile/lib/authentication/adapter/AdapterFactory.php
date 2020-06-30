<?php
/**
 * Created by PhpStorm.
 * User: dmsk
 * Date: 28.12.2017
 * Time: 15:21
 */

namespace Simbirsoft\Mobile\Authentication\Adapter;

class AdapterFactory {

    /**
     * @param $site
     * @param $params
     * @throws \Exception
     * @return AbstractAdapter|Facebook|GooglePlus|MailRu|Vkontakte|Odnoklassniki|Yandex
     */
    public static function createUserObject($site, $params)
    {
        // googleplusmobile - ��������� ���� ��� googleplus,
        // ��� �� ����������� �� ���. ������
        if (trim($site) == 'googleplusmobile') {
            $site = 'googleplus';
        }
        if (trim($site) == 'vkontaktemobile') {
            $site = 'Vkontakte';
        }

        $classname = "Simbirsoft\\Mobile\\Authentication\\Adapter\\{$site}";
        if (class_exists($classname)) {
            return new $classname($params);
        } else {
            throw new \Exception("Class {$classname} not found");
        }
    }
}