import parse from 'html-react-parser';

import twigTemplate from './digitalgovglobalsearch.twig';
import data from './digitalgovglobalsearch.yml';
import '../../../../../../modules/custom/sec_custom_blocks/js/digitalgov_global_search/smartSearch';
import '../../../../../../modules/custom/sec_custom_blocks/css/digitalgov_global_search/smartSearch.css';

// Note: When updating this dropdown to match new designs when they come in, move css and js into this component
//       Then, do a rewrite - markup and js needs some work

const settings = {
  title: 'Components/Digitalgovglobalsearch'
};

const Digitalgovglobalsearch = args =>
  parse(
    twigTemplate({
      ...args,
    })
  );
Digitalgovglobalsearch.args = { ...data };

export default settings;
export { Digitalgovglobalsearch };
