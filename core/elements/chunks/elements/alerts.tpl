<div data-action="alert" class="alert {$fixed ? 'alert--fixed' : ''}"></div>

{set $timeout = $timeout == "" ? 4000 : $timeout}
{set $noHiding = $noHiding == "" ? 0 : $noHiding}

{$_modx->regClientScript('<script>
    var closeAlert;
    var timeoutCount = '~ $noHiding ~';

    let alerts = function(result) {
        clearTimeout(closeAlert);
        let alertDOM = document.querySelector(`[data-action="alert"]`);
        
        alertDOM.classList.add("alert--" + result.state);
        alertDOM.innerHTML = result.message;
        alertDOM.style.display = "block";

        if (!timeoutCount) {
            closeAlert = setTimeout(() => {
                alertDOM.classList.add("alert--hide");

                setTimeout(() => {
                    alertDOM.classList.remove("alert--hide");
                    alertDOM.classList.remove("alert--" + result.state);
                    alertDOM.style.display = null;
                }, 300);
            }, '~ $timeout ~');
        }
    }

    let clearAlert = function() {
        let alertDOM = document.querySelector(`[data-action="alert"]`);
        alertDOM.style.display = null;
        clearTimeout(closeAlert);
    }
</script>', true)}