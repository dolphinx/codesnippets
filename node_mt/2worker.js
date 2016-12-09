"use strict"

const Worker = require('webworker-threads').Worker;

function piWorker() {
	const worker = new Worker(() => {
		this.onmessage = (event) => {
			function calc(r) {
				"use strict"
				let inside = 0;

				for (let x = 0; x < r; ++x) {
					const x2 = Math.pow(x / r, 2);
					for (let y = 0; y < r; ++y)
						if (x2 + Math.pow(y / r, 2) <= 1)
							inside++;
				}

				return inside / r / r * 4;
			}

			postMessage(calc(event.data));
		};
	});
	worker.onmessage = (event) => {
		console.log(event.data);
		var diff = process.hrtime(worker.time);
		console.log('Worker took %d ms', diff[0] * 1e3 + diff[1] / 1e6);
	};
	return worker;
}
const w1 = piWorker();
const w2 = piWorker();

function doWork1() {
	w1.time = process.hrtime();
	w1.postMessage(16300);
}
function doWork2() {
	w2.time = process.hrtime();
	w2.postMessage(16300);
}
function next() {
	doWork1();
	setTimeout(doWork2, 1500);
	setTimeout(next, 3000);
}
next();
