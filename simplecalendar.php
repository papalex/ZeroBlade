<?php ?>

<style>
  .inprogress{font-style: italic; color: darkgray; background-color: lightgoldenrodyellow}.iscomplete{background: lightgreen;}
  .calendar{width:50vw;list-style: none; margin: 0vw;background-color: lightcyan;display: flex;flex-wrap:wrap;}
  .calendar > li{border: 1px solid #b2b2b2; width:14%; height: 10vh;box-sizing: border-box;-moz-box-sizing: border-box;margin: 0vw; background-color: #DDDD50;padding: 1%;}
  .calendarhead > li{height: auto;background-color: #CCCC50; font-weight: bold;}

</style>

<ul class="calendar calendarhead">
<li>понедельник</li>
<li>вторник</li>
<li>среда</li>
<li>четверг</li>
<li>пятница</li>
<li>суббота</li>
<li>воскресенье</li>
</ul>
<ul class="calendar">

</ul>
<script language="JavaScript" type="application/javascript">
    var cal = document.querySelector('.calendar:nth-of-type(2)');
    var montharr = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    curdate = new Date();
    var month = curdate.getMonth();
    year = curdate.getFullYear();
    var firstdayofmonth = new Date(year,month+1,1);//curdate
    //firstdayofmonth.setMonth(month);
    //firstdayofmonth.setDate(1);
    lastdayofmont = new Date(year,month+1,0);
    //lastdayofmont.setMonth(month+1);
    //lastdayofmont.setDate(0);
    prevmonth = new Date(year,month,0);//new Date(firstdayofmonth);
    //prevmonth.setDate(0);
    prevmonthlastdate = prevmonth.getDate();
    daysqty = lastdayofmont.getDate();

    for (i = 0 - prevmonth.getDay(); i<=daysqty +(6-lastdayofmont.getDay()) ; i++)
    {
        li = document.createElement("li");

        if (i < 0)
        {
            //innerDate = new Date(prevmonth);
            //prevmonth.setDate prevmonth.getDate();
            //innerDate.setDate(prevmonthlastdate  +i+1);
            li.innerHTML = prevmonthlastdate  +i+1;
            li.innerHTML += '<div>'+montharr[month-1]+'</div>';//innerDate.toDateString('MMM')
            li.classList.add('inprogress');
        }
        else if (i >= daysqty)
        {
            li.innerHTML = i-daysqty+1;
            li.innerHTML += '<div>'+montharr[month+1]+'</div>';//innerDate.toDateString('MMM')
            li.classList.add('inprogress');
        }
        else
        {
            li.innerHTML = i + 1;
        }
        cal.appendChild(li);
    }
</script>
