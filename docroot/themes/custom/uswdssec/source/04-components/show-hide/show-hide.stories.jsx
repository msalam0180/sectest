import parse from 'html-react-parser';

import twigTemplate from './show-hide.twig';
import globalData from '../../00-config/storybook.global-data.yml';
import data from './show-hide.yml';
import './show-hide.es6';

const settings = {
  title: 'Components/Show Hide',
  parameters: {
    controls: {
      include: ['is_demo', 'text', 'top_element'],
    },
  },
};

const ShowHide = args =>
  parse(
    twigTemplate({
      ...args,
    })
  );
ShowHide.args = { ...globalData, ...data };

export default settings;
export { ShowHide };
