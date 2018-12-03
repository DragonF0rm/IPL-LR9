document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('#input_form');

    form.addEventListener('ajax:success', function (respond) {
        const result_status = document.querySelector('#result_status');
        const result_content = document.querySelector('#result_content');
        result_status.textContent = respond.detail[0].status;
        let str = "";
        for (let index in respond.detail[0].content) {
            str += "<tr class='content-row'><th>" + (parseInt(index)+1).toString() + "</th><th>" + respond.detail[0].content[index] + "</th></tr>"
        }
        result_content.innerHTML = str;
    })
});