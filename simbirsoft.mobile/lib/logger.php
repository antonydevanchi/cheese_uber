<?php

namespace Simbirsoft\Mobile;

/**
 *  ����� ��� ����������� � ������� ����.
 */
class Logger
{
    /*
     *  ������ �������, ������� �����: �� ������ ��������.
     */
    const DEBUG_LEVEL_NONE      = __LINE__;
    const DEBUG_LEVEL_ERROR     = __LINE__;
    const DEBUG_LEVEL_NOTIFY    = __LINE__;
    const DEBUG_LEVEL_LOG       = __LINE__;
    const DESTRUCT_STRING       = '==========';

    const KEY_MSG   = 'message';
    const KEY_TIME  = 'time';
    const KEY_TYPE  = 'type';

    const LINE_TYPE_FINISH = 'finish';

    private $DEBUG_LEVELS = array(
        self::DEBUG_LEVEL_ERROR,
        self::DEBUG_LEVEL_NOTIFY,
        self::DEBUG_LEVEL_LOG,
    );

    private $dirname = __DIR__;
    private $handle = null;

    private $debug_level = self::DEBUG_LEVEL_NONE;
    private $filename = null;

    /**
     * ����������� ������.
     *
     * @param string    $filename       ��� �����, � ������� ����� ��������� ����.
     * @param int       $debug_level    ������� �����������
     * @param string    $dir_name       ���� � ����������, � ������� ����� ��������� ���� �����
     */
    public function __construct($filename, $debug_level = null, $dir_name = '') {
        if (!empty($dir_name))
            $this->dirname = $dir_name. '/';
        else
            $this->dirname = realpath($this->dirname . '/..') . '/log/';

        if (!file_exists($this->dirname)) {
            var_dump(mkdir($this->dirname, 0777, true));
        }

        $this->filename = $filename;
        if (empty($this->filename)) {
            $this->filename = 'log.log';
        }
        $this->handle = fopen($this->dirname . $filename, 'a+');
        $this->setDebugLevel($debug_level);
    }

    /**
     *  ��������� ������ �������.
     *  @param  DEBUG_LEVEL_*   $level
     */
    public function setDebugLevel($level) {
        if (in_array($level, $this->DEBUG_LEVELS)) {
            $this->debug_level = $level;
        }
    }

    /**
     *  ������ � ��� ����. ������� ������ DEBUG_LEVEL_LOG.
     *  @param  string  $string
     */
    public function log($string) {
        $string = $this->prepareLogValue($string);
        $this->add('LOG: ' . $string, self::DEBUG_LEVEL_LOG);
    }

    /**
     *  ������ � ��� ����. ������� ������ DEBUG_LEVEL_NOTIFY.
     *  @param  string  $string
     */
    public function notify($string) {
        $string = $this->prepareLogValue($string);
        $this->add('NOTIFY: ' . $string, self::DEBUG_LEVEL_NOTIFY);
    }

    /**
     *  ������ � ��� ����. ������� ������ DEBUG_LEVEL_ERROR.
     *  @param  string  $string
     */
    public function error($string) {
        $string = $this->prepareLogValue($string);
        $this->add('ERROR: ' . $string, self::DEBUG_LEVEL_ERROR);
    }

    /**
     *  ������ � ��� ����.
     *  @param  string          $string
     *  @param  DEBUG_LEVEL_*   $level
     */
    private function add($string, $level) {
        if ($this->debug_level >= $level) {
            fwrite($this->handle, date('Y-m-d H:i:s') . ' ' . $string . PHP_EOL);
        }
    }

    /**
     *  ������� ����������� ���-�����.
     */
    public function clear() {
        ftruncate($this->handle, 0);
    }

    /**
     *  ���������� ����������� �������� � ������
     *  @param  mixed   $string
     *  @return string
     */
    private function prepareLogValue($string) {
        if (is_string($string)) {
            return $string;
        } else {
            return var_export($string, 1);
        }
    }

    /**
     *  ���������� ������.
     */
    public function __destruct() {
        $this->add(self::DESTRUCT_STRING . PHP_EOL, self::DEBUG_LEVEL_ERROR);
        fclose($this->handle);
    }


    /**
     * ��������� ��������� � ������ �������� ����� ����
     *
     * @return bool
     */
    public function startReading() {
        return rewind($this->handle);
    }


    /**
     * ��������� ������ �� ����� ���� � ������ � �� �����.
     *
     * @return array|false
     */
    public function readLineToArray() {
        $s = fgets($this->handle);
        if ($s === false) {
            return false;
        }
        $line = explode(' ', rtrim($s, PHP_EOL));
        $date = array_shift($line);
        $result = array(
            'date'          => strtotime($date),
            self::KEY_TIME  => strtotime($date . ' ' . array_shift($line)),
        );
        if ($line[0] == self::DESTRUCT_STRING) {
            $result[self::KEY_TYPE] = self::LINE_TYPE_FINISH;
            // ��������� ������ ������, ��������� �
            fgets($this->handle);
        } else {
            $result[self::KEY_TYPE] = 'line';
            $result['level']        = rtrim(array_shift($line), ':');
            $result[self::KEY_MSG]  = implode(' ' , $line);
        }
        return $result;
    }

    /**
     * ����������� �����������
     *
     * @param $text
     * @param $data
     */
    public function extendLog($text, $data) {
        $log_data = $text . PHP_EOL;
        $log_data .= 'URI: ' . $_SERVER['REQUEST_URI'] . PHP_EOL;
        $log_data .= '���������: ' . print_r($_REQUEST, true) . PHP_EOL;
        $log_data .= '������������: ' . \CUser::GetID() . PHP_EOL;
        $log_data .= '������: ' . print_r($data, true);
        $this->log($log_data);
    }

    /**
     * @return null|string
     */
    public function getFilename() {
        return $this->filename;
    }
}
