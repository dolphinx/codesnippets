"use strict"

const pool = require('webworker-threads').createPool(4);
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

pool.all.eval(calc);
function next() {
	const time = process.hrtime();
	pool.any.eval('calc(16300)', (err, data) => {
		console.log(data);
		var diff = process.hrtime(time);
		console.log('pool took %d ms', diff[0] * 1e3 + diff[1] / 1e6);
	});
	setTimeout(next, 1500);
}
next();