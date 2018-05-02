<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class SECTIONS
{
    const INSERT = 1;
    const EXTEND = 2;
    const STARTFOUND = 3;
    const INSERTED=4;
}
class ZeroBlade
{
    public $sections =[];
    public $extends = [];
    public $curview;
    public $seccontent;
    public function render($view)
    {
        $this->curview = $view;
        
        include (VIEWSPATH.DIRECTORY_SEPARATOR.$view.'.php');
    }
    public function extend($view)
    {
        //extract(['renderer'=>$this]);
        if (isset($this->extends[$view]) && isset($this->extends[$view][$this->curview]))
        {
                $this->extends[$view][$this->curview]++;         
        }
        else
        {
            $this->extends[$view][$this->curview] = 1;
            ob_start();
            require (VIEWSPATH.DIRECTORY_SEPARATOR.$view.'.php');
        }
    }
    public function section($sectionname)
    {
        if (isset($this->sections[$sectionname]) && $this->sections[$sectionname] === SECTIONS::INSERT)
        {
            return $sectionname;
        }
        else
        {            
            $this->sections[$sectionname] = SECTIONS::STARTFOUND;
            ob_start();
        }
        
    }
    public function endsection($sectionname)
    {
        if ($this->sections[$sectionname] === SECTIONS::STARTFOUND)
        {
            $this->seccontent[$sectionname] = ob_get_clean();
        }
        return $sectionname;
    }
    public function insertSection($sectionname)
    {
        $this->sections[$sectionname] = SECTIONS::INSERT;
        include (VIEWSPATH.DIRECTORY_SEPARATOR.$this->curview.'.php');
        $this->sections[$sectionname] = SECTIONS::INSERTED;
        ob_get_flush();
        return $sectionname;
    }
    
}
class ZB extends ZeroBlade
{
    public static function xd($args,$level=10,$fine=true)
    {
        xdebug_var_dump($args);
    }
}

