let date = new Date();

const CCalender = () => {// 달력보여주는 함수
	const viewYear = date.getFullYear();
	const viewMonth = date.getMonth();
	
	// 현재 연도와 월 표시
	document.querySelector('.year-month').textContent = `${viewYear}년 ${viewMonth + 1}월`;
	
	//지난 달 마지막 날과 이번달 마지막날
	const prevLast = new Date(viewYear, viewMonth, 0);
	const thisLast = new Date(viewYear, viewMonth + 1, 0);

	const PLDate = prevLast.getDate();//지난달 마지막 날
	const PLDay = prevLast.getDay();//지난달 마지막 요일

	const TLDate = thisLast.getDate();//이번달 마지막 날
	const TLDay = thisLast.getDay();//이번달 마지막 요일

	const prevDates = [];
	const thisDates = [...Array(TLDate + 1).keys()].slice(1);
	const nextDates = [];
	
	//달력합치기
	if (PLDay !== 6) {
		for (let i = 0; i < PLDay + 1; i++) {
			prevDates.unshift(PLDate - i);//지난달 날짝들 넣기
		}
	}

	for (let i = 1; i < 7 - TLDay; i++) {
		nextDates.push(i);//다음달 날짜 넣기
	}

	const dates = prevDates.concat(thisDates, nextDates);//지난달 이번달 다음달 합치기

	const firstDateIndex = dates.indexOf(1);//이번달 1일 인덱스 찾기
	const lastDateIndex = dates.lastIndexOf(TLDate);//이번달 마지막 날 인덱스 찾기
	
	dates.forEach((date, i) => {
		const condition = i >= firstDateIndex && i < lastDateIndex + 1 ? 'this' : 'other';
		dates[i] = `<div class="date"><span class="${condition}">${date}</span></div>`;
		//<div class="date" onclick="openEventModal(${viewYear}, ${viewMonth}, ${date})"><span class="${condition}">${date}</span></div>를 넣으면 클릭

	});

	document.querySelector('.dates').innerHTML = dates.join('');
	
	//오늘 날짜 표시하기
	const today = new Date();
	if(viewMonth === today.getMonth() && viewYear === today.getFullYear()){
		for(let date of document.querySelectorAll('.this')) {
			if(+date.innerText === today.getDate()){
				date.classList.add('today');
				break;
			}
		}
	}
};

CCalender();

//지난달 이동
const prevMonth = () => {
	date.setMonth(date.getMonth()-1);
	CCalender();
};

//다음달 이동
const nextMonth = () => {
	date.setMonth(date.getMonth()+1);
	CCalender();
};

//이번달 이동
const goToday = () => {
	date = new Date();
	CCalender();
};

/*날짜 클릭시 모달 오픈
const openEventModal = (year, month, day) => {
  const eventDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
  document.getElementById('eventDate').value = eventDate;
  const eventModal = new bootstrap.Modal(document.getElementById('eventModal'));
  eventModal.show();
};
*/
/* 데베를 이용하여 진행 사실 이부분은 잘모르겠다
document.getElementById('eventForm').addEventListener('submit', (e) => {
  e.preventDefault();
  const eventDate = document.getElementById('eventDate').value;
  const eventTitle = document.getElementById('eventTitle').value;
  const eventDescription = document.getElementById('eventDescription').value;

  // 서버에 일정 저장 요청
  fetch('/addEvent', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      date: eventDate,
      title: eventTitle,
      description: eventDescription
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      alert('일정이 추가되었습니다.');
      location.reload();
    } else {
      alert('일정 추가에 실패했습니다.');
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });
});
*/
